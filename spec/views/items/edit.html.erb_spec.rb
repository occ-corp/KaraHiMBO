require 'spec_helper'

describe "/items/edit.html.erb" do
  before(:each) do
    assigns[:item] = @item = stub_model(Item,
      :new_record? => false,
      :name => "value for name",
      :second_category_id => 1,
      :unit => "value for unit",
      :target_index => "value for target_index",
      :entire_index => 1.5,
      :person_year_index => 1.5,
      :person_month_index => 1.5,
      :comparison_id => 1
    )
  end

  it "renders the edit item form" do
    render

    response.should have_tag("form[action=#{item_path(@item)}][method=post]") do
      with_tag('input#item_name[name=?]', "item[name]")
      with_tag('input#item_second_category_id[name=?]', "item[second_category_id]")
      with_tag('input#item_unit[name=?]', "item[unit]")
      with_tag('input#item_target_index[name=?]', "item[target_index]")
      with_tag('input#item_entire_index[name=?]', "item[entire_index]")
      with_tag('input#item_person_year_index[name=?]', "item[person_year_index]")
      with_tag('input#item_person_month_index[name=?]', "item[person_month_index]")
      with_tag('select#item_comparison_id[name=?]', "item[comparison_id]")
    end
  end
end
