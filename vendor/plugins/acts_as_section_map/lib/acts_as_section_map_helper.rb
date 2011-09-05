module XibbarNet
  module Acts #:nodoc:
    module SectionMapHelper
      def section_map(object_name,options = {},&block)
        defaults = {
          :table=>{:border => '1'},
          :tr=>{},
          :td=>{}
        }
        options = defaults.merge options
        table2=object_name.to_s.classify.constantize.table2

        concat tag(:table,options[:table]),block.binding
        table2.each do |ytable|
          concat tag(:tr,options[:tr]),block.binding
          ytable.each do |table|
            concat tag(:td,options[:td].merge({:colspan=>table.colspan,:rowspan=>table.rowspan})),block.binding
            block.call(table)
            concat "</td>",block.binding
          end
          concat "</tr>",block.binding
        end
        concat "</table>",block.binding
      end
    end

  end
end
