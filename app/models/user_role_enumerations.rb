module UserRoleEnumerations
  extend Enumerize
  enumerize :role, in: [:operator, :manager, :president, :admin, :system], scope: true
end
