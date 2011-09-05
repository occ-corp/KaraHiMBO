class FirstCategory < ActiveRecord::Base
  has_many :second_categories, :dependent => :destroy
  belongs_to :division
end
