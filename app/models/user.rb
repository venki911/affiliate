class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :lockable, :timeoutable and :activatable,:confirmable
  devise :database_authenticatable, :registerable, :omniauthable,
         :recoverable, :rememberable, :trackable, :validatable



  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation,:is_admin,:username,:remember_me, :name, :address, :paypal_info_attributes
  before_create :set_key
  has_many :transactions
  has_one :paypal_info
  has_many :payment_requests
  accepts_nested_attributes_for :paypal_info


  def apply_omniauth(omniauth)
    self.name = omniauth['user_info']['name'] if name.blank?
    self.provider = omniauth['provider']
    self.uid = omniauth['uid']
  end

  def self.all_users_without_admin
    find(:all, :conditions => ['is_admin = ? or is_admin IS NULL', 0])
  end

  def earnings_total_price
     self.transactions.sum(:commissions)
  end

  def update_earnings
    self.update_attribute('earnings',  self.transactions.sum(:commissions))
  end

  def remaining_earnings
    self.earnings.to_f - self.withdrawals.to_f
  end


  def name_or_email
    name.blank?? email : name
  end

  def create_payment_request(amount)
    pr = payment_requests.find_by_state('pending')
    if pr.blank?
     payment_requests.create(:amount => amount)
    end
  end

  private

  def set_key
    self.key = ActiveSupport::SecureRandom.hex(40)
  end
end

