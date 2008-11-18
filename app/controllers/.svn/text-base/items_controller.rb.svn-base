require 'pp'

class ItemsController < ApplicationController
  
  before_filter :login_required
  before_filter :get_time

  # Autocomplete the name
  def auto_complete_for_item_name_with_security
    Item.with_user_scope(current_user) do
      auto_complete_for_item_name_without_security
    end
  end
  auto_complete_for :item, :name, :limit => 10
  alias_method_chain :auto_complete_for_item_name, :security
  
  # Autocomplete the form category
  def auto_complete_for_category_name_with_security
    Category.with_user_scope(current_user) do
      auto_complete_for_category_name_without_security
    end
  end
  def auto_complete_for_item_form_category
    params[:category] ||= {}
    params[:category][:name] = params[:item][:form_category]
    auto_complete_for_category_name
  end
  auto_complete_for :category, :name
  alias_method_chain :auto_complete_for_category_name, :security
  
  
  def prev_month
    set_time(get_time - 1.month)
    redirect_to_index_or_reports
  end
  
  def next_month
    set_time(get_time + 1.month)
    redirect_to_index_or_reports
  end
  
  def this_month
    set_time(nil)
    redirect_to_index_or_reports
  end

  def reports
    session[:show_items] = false
    load_reports
  end
  
  def index
    session[:show_items] = true
    load_items
  end
  
  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    respond_to { |format|
      format.js { 
        if in_items?
          load_items
          render(:update) { |page| 
            page['income'].replace_html :partial => 'items', :object => @income_items
            page['expenses'].replace_html :partial => 'items', :object => @expense_items
          } 
        else
          load_reports
          render(:update) { |page| 
            page['report_items'].replace_html :partial => 'reports'
          }
        end
      }
      format.html { redirect_to :action => :index }
    }
  end
  
  def update
    @updated_item = Item.find(params[:id])
    success = @updated_item.update_attributes(params[:item])
    update_id = 'item_row_' + @updated_item.id.to_s
    respond_to { |format|
      format.js {
        if in_items?
          load_items
          render(:update) { |page| 
            page['income'].replace_html :partial => 'items', :object => @income_items
            page['expenses'].replace_html :partial => 'items', :object => @expense_items
            page << "if ($('#{update_id}')) {"
            page[update_id].visual_effect :highlight, :duration => 1
            page << "}"
          }
        else
          load_reports
          render(:update) { |page| 
            page['report_items'].replace_html :partial => 'reports'
            page << "if ($('#{update_id}')) {"
            page[update_id].visual_effect :highlight, :duration => 1
            page << "}"
          }
        end
      }
    }
  end
  
  def create
    @item = Item.new
    @item.user = current_user
    @item.attributes = params[:item]
    if @item.save
      load_items
      @saved_item = @item
      @item = Item.new(:expense=>@item.expense?, :tx_date=>@item.tx_date)
      respond_to { |format|
        format.js { 
          render(:update) { |page| 
            page['item_form_div'].replace_html :partial => 'form', :locals => {:expense => true, :time=>@time }
            page['income'].replace_html :partial => 'items', :object => @income_items
            page['expenses'].replace_html :partial => 'items', :object => @expense_items
            update_id = 'item_row_' + @saved_item.id.to_s
            page << "if ($('#{update_id}')) {"
            page[update_id].visual_effect :highlight, :duration => 1
            page << "}"
            page['item_name'].focus
          } 
        }
      }
    else
      respond_to { |format|
        format.js { 
          render(:update) { |page| 
            page['item_form_div'].replace_html :partial=>'form'
            page['item_name'].focus
          }
        }
      }
    end
  end
  
  private

  def in_items?
    session[:show_items]
  end

  def in_reports?
    !in_items?
  end

  def start_of_current_month
    now = Time.now.change(:day=>1, :hour=>0)
  end

  def get_time
    @time = session[:time] ||= start_of_current_month
  end
  
  def set_time(time)
    session[:time] = @time = time
  end
  
  def load_items
    @expense_items = Item.find_for_user_and_time_and_expense(current_user, @time, true)
    @income_items = Item.find_for_user_and_time_and_expense(current_user, @time, false)
  end

  def load_reports
    load_items
    @expense_categories = @expense_items.group_by(&:category).collect { |category, items| 
      {:category_name => (category ? category.name : 'Uncategorized'), :items => items }
    }.sort_by { |hash|
      category_sum = hash[:items].inject(0) {|sum,item| sum + item.amount} * -1 # reverse order
    }
  end

  def redirect_to_index_or_reports
    redirect_to :action => (session[:show_items] ? :index : :reports )
  end
  
  
end
