# -*- coding: utf-8 -*-
class Belong < ActiveRecord::Base
  belongs_to :employee
  belongs_to :division
  belongs_to :post  

  has_many :actuals
end
