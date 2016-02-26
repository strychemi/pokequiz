class User < ActiveRecord::Base
  after_create :send_mail
  include AnswerStats

  has_secure_password

  has_one :profile, inverse_of: :user, dependent: :destroy
  has_many :activities
  has_many :results

  has_many :initiated_followings, class_name: 'Following'
  has_many :followeds, through: :initiated_followings, class_name: 'User'

  has_many :received_followings, class_name: 'Following'
  has_many :followers, through: :received_followings, class_name: 'User'

  validates :password,
          :length => { :in => 8..24 },
            :allow_nil => true
  validates :email, presence: true, uniqueness: true

  validates :profile, presence: true

  accepts_nested_attributes_for :profile,
                                :reject_if => :all_blank


  after_create :generate_token

  def generate_token
    self.auth_token = SecureRandom.uuid + "-" +  Digest::MD5.hexdigest("#{email}")
  end

  def regenerate_auth_token
    self.auth_token = nil
    generate_token
    save!
  end

  def send_mail
    User.send_welcome_email(self.id)
  end

  class << self
    def send_welcome_email(id)
      user = User.find(id)
      UserMailer.welcome_email(user).deliver!
    end
    handle_asynchronously :send_welcome_email
  end
end
