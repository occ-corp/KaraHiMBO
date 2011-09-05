# -*- coding: utf-8 -*-
class Division < ActiveRecord::Base
  has_many :belongs
  has_many :employees, :through => :belongs, :source => 'employee'
  has_many :posts, :through => :belongs, :source => 'post'

  has_many :divisions_items
  has_many :items, :through => :divisions_items

  has_many :first_categories

  validates_presence_of :code, :name

  acts_as_nested_set
  acts_as_section_map

  #
  # 木の深さを返す
  # root は level=0 とする
  #
  def self.max_level
    result = Division.connection.select_all(<<SQL)
SELECT MAX(level) AS level
FROM (
  SELECT COUNT(parent.name)-1 AS level
  FROM #{Division.table_name} AS node,
       #{Division.table_name} AS parent
  WHERE node.lft BETWEEN parent.lft AND parent.rgt
  GROUP BY node.name
) AS TMP
SQL
    return result[0]["level"].to_i
  end


  def self.rebuild
    Division.all.each do |d|
      if d.parent_id
        parent = Division.find(d.parent_id)
        parent.add_child(d)
      end
    end
  end

  # 自身および下位部署に所属する社員を配列で返す
  def belong_employees
    return Employee.find(:all, :include => :belongs,
                         :conditions => {
                           :belongs => {
                             :division_id => self.children_ids(:include_own => true)
                           }
                         })
  end

  # 自身の下位に属する部署の ID を配列で返す
  # 引数に :include_own => trueを指定すると、自身を含める IDs を返す
  # 引数を省略するか、:include_own => false を指定すると自身を含めない
  #
  # ==== Example
  # p parent.id                        #=> 1
  # parent.children_ids                #=> [2,3,4,5]
  # parent.children_ids(:include_own)  #=> [1,2,3,4,5]
  def children_ids(opt = {})
    opt[:include_own] ||= false
    opt[:level] ||= self.level
    ids = self.all_children.collect { |d| d.id }
    ids << self.id if opt[:include_own]
    return ids
  end

  # 自身から最上位部署までの名前をつなげて返す
  #
  # +sep+ :: 各部署の間に入れる文字列。デフォルトでスペース
  #
  #= Example
  # @division.full_name
  #   #=> A本部 C部 D課
  # @division.full_name(' -> ')
  #   #=> A本部 -> C部 -> D課
  def full_name(sep = " ")
    names = self.self_and_ancestors.collect { |d| d.name }
    return names.join(sep)
  end

  #
  # 自身と、その先祖及びすべての子供を返す
  #
  #     A 
  #    / \
  #   B  C
  #   |
  #   D
  #  / \
  # E   F
  #
  # D.ancestors_and_all_children #=> [A, B, D, E, F]
  #
  def ancestors_and_all_children
    return self.self_and_ancestors + self.all_children
  end

end
