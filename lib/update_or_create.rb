# -*- coding: utf-8 -*-
#
#= AvtiveRecord::Base#update_or_create
#
# この拡張では、ActiveRecord::Base の update_attributes と create を
# 同時に行うことが可能となります。
#
#== 参考
#
# find_or_create
# http://d.hatena.ne.jp/technohippy/20091009#1255065251
#
#= インストール
#
# RAILS_ROOT/config/environment.rb とかに書けばきっと動く。
# 他にもいろいろロードの仕方はありますが。そこは任せる！
class ActiveRecord::Base
  #
  # update_or_create
  #
  # レコードを update する。もしそのレコードが存在しなければ create する
  # その時のレコードの値は +cond_attr+ と +set_attr+ の merge となる
  #
  # +cond_attr+ :: update したいレコードの condition (Hash)
  # +set_attr+  :: update したいカラムの値 (Hash)
  # return      :: update された数
  #                もし 0 なら、update されずに create されている
  #
  # Usage:
  #  Diary(title:string, body:text) っていう Model があるとする
  #
  # Diary.update_or_create({:title => "start"}, {:body => "hello!!"})
  #   # => 0
  # Diary.all
  #   # => [#<Diary id: 1, title: "start", body: "hello!!", created_at: "2009-11-16 12:33:28", updated_at: "2009-11-16 12:33:28">]
  # Diary.update_or_create({:title => "sleepy"}, {:body => "zzz..."})
  #   # => 0
  # Diary.all
  #   # => [#<Diary id: 1, title: "start", body: "hello!!", created_at: "2009-11-16 12:33:28", updated_at: "2009-11-16 12:33:28">, #<Diary id: 2, title: "sleepy", body: "zzz...", created_at: "2009-11-16 12:34:12", updated_at: "2009-11-16 12:34:12">]
  # Diary.update_or_create({:title => "start"}, {:body => "Hello, World!!"})
  #   # => 1
  # Diary.all
  #   # => [#<Diary id: 1, title: "start", body: "Hello, World!!", created_at: "2009-11-16 12:33:28", updated_at: "2009-11-16 12:33:28">, #<Diary id: 2, title: "sleepy", body: "zzz...", created_at: "2009-11-16 12:34:12", updated_at: "2009-11-16 12:34:12">]
  def self.update_or_create(cond_attr, set_attr)
    return -1 if set_attr.nil? || set_attr.empty?

    count = self.update_all(set_attr, cond_attr)

    if count == 0
      cond_array = cond_attr.to_a
      conditions =
        [ 
         cond_array.map{|pair| "#{pair.first} = ?"}.join(' AND '),
         *cond_array.map{|pair| pair.last}
        ]
      create!(cond_attr.merge(set_attr))
    end

    return count
  end 
end 
