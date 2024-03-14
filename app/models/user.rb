class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_and_belongs_to_many :projects
  enum role: {manager: 0, quality_assurance: 1, developer: 2}
  has_many :bugs, dependent: :destroy
end
