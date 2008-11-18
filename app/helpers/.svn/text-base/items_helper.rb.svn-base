module ItemsHelper
  
  def in_place_edit(model, method)
    text = self.instance_variable_get("@#{model.to_s}").send(method)
    content_tag(:span, text,
      :onMouseOver => "new Effect.Highlight(this, {startcolor:'#ffff99', endcolor:'#ffffff', restorecolor:'#ffffff'})"
    )
  end
  
  def time_to_current_month(time)
    names = %w(January February March April May June July August September Octover November December)
    month = time.month
    year = time.year
    "#{names[month-1]}, #{year}"
  end

  def items_table(opts={}, &block)
    opts.reverse_merge! :edit => true
    @template.concat("<table class='items'>", block.binding)
    @template.concat("<tr class='item_label_row'>", block.binding)
    headers = %w(Date Name Amount Category Memo)
    headers << 'Option' if opts[:edit]
    headers.each {|n| 
      @template.concat("<td>#{n}</td>", block.binding)
    }
    @template.concat("</tr>", block.binding)
    @odd = true
    yield
    @template.concat("</table>", block.binding)
  end
  
  
  
end
