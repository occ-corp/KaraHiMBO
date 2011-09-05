# -*- coding: utf-8 -*-
# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def select_nested_set(object, method, type, blank = type.to_s, options = {}, html_options = {})
    select(object, method, nested_set_options_for_select(type, options) { |item| "#{ '　' * item.level}#{item.name}" },
           {:include_blank => blank}, html_options)
  end

  def select_nested_set_tag(name, type, blank = type.to_s, selected = [], options = { }, html_options = { })
    if blank.nil?
      options = options_for_select(nested_set_options_for_select(type, options) { |item|
                                     "#{ '　' * item.level}#{item.name}"
                                   },selected)
    else
      options = options_for_select(nested_set_options_for_select(type, options) { |item|
                                     "#{ '　' * item.level}#{item.name}"
                                   }.unshift([blank,""]),
                                   selected)
    end
    select_tag name, options, html_options
  end
  
  def checkbox_nested_set_name(type)
    nested_set_options_for_select(type) {  |item| "#{ '　　' * item.level} #{item.name}" }
  end
end
