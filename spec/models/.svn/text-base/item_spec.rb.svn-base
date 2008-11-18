require File.dirname(__FILE__) + '/../spec_helper'

describe Item do
  include ItemSpecHelper
  
  before :each do
    @item = Item.new(valid_item_attributes)
  end
  
  it do
    @item.should be_valid
  end

  it do
    with_blanks do |b|
      @item.name = b
      @item.should have(1).error_on(:name)
    end
  end

  it do
    @item.user =nil
    @item.should have(1).error_on(:user)
  end
  
  it do
    @item.amount = '30 dollars'
    @item.should have(1).error_on(:amount)
  end
  
end