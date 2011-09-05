# -*- coding: utf-8 -*-
class Employee < ActiveRecord::Base
  has_one :user
  belongs_to :post

  has_many :belongs, :dependent => :destroy
  has_many :divisions, :through => :belongs, :source => 'division'
  has_many :posts, :through => :belongs, :source => 'post'

  #
  # 指定した +division_id+ の部署及びその下位部署に
  # 所属する社員を返す
  # +division_id+ が nil なら、全ての社員を返す
  #
  def self.find_by_division_id(division_id, opt = { })
    opt[:all] ||= true
    d_ids = Division.find(division_id).children_ids(:include_own => true)

    return Employee.find(:all, :include => :belongs,
                         :conditions => {
                           :belongs => { :division_id => d_ids }
                         })
  end

  # 社員が所属する、+division+ を含むそれ以下の部署での役職を部署名とともに返す
  # +division+ が nil であれば、全部署から社員が所属するデータを返す
  def divisions_and_posts(division = nil)
    case division.class.to_s
    when "Division"
      ids = division.children_ids(:include_own => true)
    when "Fixnum", "String"
      ids = Division.find(division).children_ids(:include_own => true)
    when "NilClass"
      ids = Division.all.collect { |d| d.id }
    end

    return Belong.find(:all, :include => [:division, :post],
                       :conditions => {
                         :employee_id => self.id,
                         :division_id => ids
                       },
                       :order => "primary_flag desc")
  end

  def primary_belong
    return Belong.find(:first, :conditions => { 
                         :employee_id => self.id
                       },
                       :order => "primary_flag desc")
  end


  #
  # 所属名、(役職についていれば)役職名を含めた社員名を返す
  #
  # +belong+ : 所属。デフォルトでは社員の primary_belong
  # +sep+    : 所属名と社員名のセパレート
  # 
  def full_name_with_belong(belong = self.primary_belong, sep = " : ")
    name = belong.division.full_name + sep + self.name
    name += " " + belong.post.name if belong.post
    return name
  end
end
