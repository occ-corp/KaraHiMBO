class SecondCategory < ActiveRecord::Base
  has_many :items, :dependent => :destroy
  belongs_to :first_category
end
