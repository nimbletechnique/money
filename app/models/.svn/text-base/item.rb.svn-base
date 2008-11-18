class Item < ActiveRecord::Base
  include ActionView::Helpers::NumberHelper
  
  belongs_to :user
  belongs_to :category
  
  validates_presence_of :user
  validates_presence_of :name
  validates_numericality_of :amount
  
  before_save :ensure_tx_date
  
  def self.with_user_scope(user)
    with_scope(:find => { :conditions => "user_id = #{user.id}"}) do
      yield
    end
  end
  
  def self.find_for_user_and_time_and_expense(user_id,time,expense)
    time_start = time
    time_end = time.advance(:months=>1)
    Item.find :all, 
              :conditions=>['user_id = ? and expense = ? and tx_date >= ? and tx_date < ?', user_id, expense, time_start, time_end],
              :order=>'tx_date DESC'
  end

  def self.find_all_for_user_and_time(user_id, time)
    time_start = time
    time_end = time.advance(:months=>1)
    Item.find :all, 
              :conditions=>['user_id = ? and tx_date >= ? and tx_date < ?', user_id, time_start, time_end],
              :order=>'tx_date DESC'
  end
  
  def inline_amount
    number_to_currency(amount)
  end
  def inline_amount=(inline_amount)
    self.amount = inline_amount.gsub(/[^0-9.]/,'').to_f unless inline_amount.blank?
  end

  def inline_category
    return "None" unless category
    category.name
  end
  def inline_category=(inline_category)
    self.category = nil and return if inline_category == "None" or inline_category.blank?
    self.form_category = inline_category
  end
  
  def inline_memo
    return "None" if memo.blank?
    memo
  end
  def inline_memo=(inline_memo)
    self.memo = nil and return if inline_memo == "None" or inline_memo.blank?
    self.memo = inline_memo
  end
  
  def inline_tx_date
    "#{sprintf('%02d',tx_date.month)}/#{sprintf('%02d',tx_date.day)}/#{tx_date.year}" if tx_date
  end
  def inline_tx_date=(inline_tx_date)
    self.tx_date = Time.parse(inline_tx_date, tx_date || Time.now)
  end
  
  
  def form_category
    return category.name if category
  end
  
  def form_category=(form_category)
    self.category = nil and return if form_category.blank? 
    found = user.categories.find_by_name(form_category)
    self.category = found and return if found
    self.category = Category.new(:user => user, :name => form_category)
  end
  
  def validate
    if amount and amount <= 0
      errors.add(:amount, 'must be > 0')
    end
  end

  private
  
  def ensure_tx_date
    self.tx_date = Time.now unless tx_date
  end
  
  
end
