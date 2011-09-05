class Post < ActiveRecord::Base
  has_many :belongs
  has_many :employees, :through => :belongs, :source => 'employee'
  has_many :divisions, :through => :belongs, :source => 'division'
end
