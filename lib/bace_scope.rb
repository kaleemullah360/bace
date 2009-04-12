module BaceScope
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      self.send(:include, InstanceMethods)
      alias_method_chain :validate, :bace
      class << self
        alias_method_chain :find, :bace
      end
    end
  end

  module ClassMethods
    #重新定义find方法，在查询前加入权限条件
    #TODO:重构，把动态查询部分代码重构
    def find_with_bace(*args)
      if Current.user_proc && Current.controller_proc #for test
        scopes = Current.user.scopes_for_resource(self, Current.controller_name, Current.action_name)
        find_scope = LimitScope.full_scops_conditions(scopes)
        #dynamic_search
        if Current.controller.params[:dynamic_search_model] == self
          dynamic_condition = Current.controller.params[:dynamic_search].to_condition
          if dynamic_condition.present?
            dynamic_condition = ' and ' + dynamic_condition if find_scope[:conditions].present?
            find_scope[:conditions] ||= ''
            find_scope[:conditions] += dynamic_condition
          end
        end
      end
      if scopes.present? || dynamic_condition.present?
        with_scope(:find => find_scope) do
          find_without_bace( *args )
        end
      else
        find_without_bace(*args)
      end
    end
  end

  module InstanceMethods
    def validate_with_bace
      scopes = Current.user.scopes_for_resource(self.class, Current.controller_name, Current.action_name) if Current.user_proc
      self.errors.add_to_base("你没有权限保存该数据，请检查：#{LimitScope.full_inspects(scopes)}") unless self.instance_eval(LimitScope.full_checks(scopes))
      validate_without_bace
    end
  end
end