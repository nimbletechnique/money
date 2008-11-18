require File.dirname(__FILE__) + '/spec_helper'

describe Graph do
  
  before :each do
    @auto = mock_model(Category, :name => 'Auto')
    @groceries = mock_model(Category, :name => 'Groceries')
    @health = mock_model(Category, :name => 'Health')

    
    @user_expenses = []
    
    @user = mock_model(User)
    @user.should_receive(:categories_and_totals).and_return(@user_expenses)
    @graph = Graph.new(@user)
  end
  
end