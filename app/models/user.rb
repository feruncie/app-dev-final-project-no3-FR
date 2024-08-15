# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  biography              :text
#  current_occupation     :text
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :text
#  goals                  :text
#  industry               :text
#  interests              :text
#  last_name              :text
#  linkedin_profile       :string
#  location               :text
#  mentee                 :boolean
#  mentor                 :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
