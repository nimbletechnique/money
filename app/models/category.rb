class Category < ActiveRecord::Base
  
  belongs_to :user
  has_many :items
  
  validates_presence_of :user
  validates_presence_of :name
  
  def self.with_user_scope(user)
    with_scope(:find => { :conditions => "user_id = #{user.id}"}) do
      yield
    end
  end
  
end
