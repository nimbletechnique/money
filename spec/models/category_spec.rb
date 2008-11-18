require File.dirname(__FILE__) + '/../spec_helper'

describe Category do
  include CategorySpecHelper
  
  before :each do
    @category = Category.new(valid_category_attributes)
  end
  
  it do
    @category.should be_valid
  end
  
  it do
    with_blanks do |b|
      @category.name = b
      @category.should have(1).error_on(:name)
    end
  end
  
  it do
    @category.user = nil
    @category.should have(1).error_on(:user)
  end
  
end