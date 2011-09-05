class Item < ActiveRecord::Base
  has_many :divisions_items, :dependent => :destroy
  has_many :divisions, :through => :divisions_items

  belongs_to :comparison
  belongs_to :second_category

  has_many :actuals

  validates_presence_of :name, :second_category_id, :unit, :target_index
  validates_presence_of :person_year_index, :person_month_index, :comparison_id

  named_scope :with_category, :joins => {:second_category => :first_category}

  def self.find_with_categories(id)
    Item.with_category.find(id, :select => <<SQL
#{Item.table_name}.*,
#{SecondCategory.table_name}.name as second_category_name,
#{FirstCategory.table_name}.name as first_category_name
SQL
)
  end
end
