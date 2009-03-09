class Role < ActiveRecord::Base
  acts_as_nested_set

  has_many :roles_users, :dependent => :destroy
  has_many :users, :through => :roles_users

  has_many :permissions_roles, :dependent => :destroy
  has_many :permissions, :through => :permissions_roles
  
  has_many :limit_scopes

  validates_uniqueness_of :name

  def has_permission?(permission)
    permission = Permission.find(permission) if permission.is_a?(Integer)
    self_and_ancestors.reverse.each do |role|
      granted =  role.self_has_permission?(permission)
      return granted unless granted.nil?
    end
    nil
  end

  def self_has_permission?(permission)
    permission = Permission.find(permission) if permission.is_a?(Integer)
    return true if permission.can_public?
    permission.self_and_ancestors.reverse.each do |p|
      granted = p.granted_to_role?(self)
      return granted unless granted.nil?
    end
    nil
  end
  
  def can_do_resource?(controller, action)
    resource = Resource.find_by_controller_and_action(controller, action)
    has_permission?(resource.permission) if resource
  end

  #角色定义的scope
  def scopes_for_permission(permission)
    unlimit_scopes = limit_scopes.find_without_bace(:all, :conditions => {:permission_id => permission})
    unlimit_scopes.map(&:to_condition)
  end

  def scopes_for_resource(controller, action)
    resource = Resource.find_without_bace(:first, :conditions => {:controller => controller, :action => action})
    permission = Permission.find_without_bace(:first, :conditions =>{:id => resource.permission_id}) if resource
    permission ? scopes_for_permission(permission) : []
  end

  def method_missing(method_name, *args)
    if match = /^can_(\w+?)_(\w+?)\?$/.match(method_name.to_s)
      #TODO:也有单数形式的controller...
      return can_do_resource?(match[2].pluralize, match[1])
    else
      super
    end
  end
end

