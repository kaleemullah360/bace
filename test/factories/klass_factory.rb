Factory.define :klass do |klass|
  klass.name 'User'
  klass.remark 'User'
  klass.position '1'
  klass.kind_id '1'
end

Factory.define :date_klass, :class => Klass do |klass|
  klass.name 'Date'
  klass.remark 'Date'
  klass.position '1'
  klass.kind_id '2'
end