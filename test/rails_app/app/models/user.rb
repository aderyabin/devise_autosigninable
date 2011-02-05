class User < ActiveRecord::Base
  # Include default devise modules.
  # Others available are :lockable, :timeoutable and :activatable.
  devise :registerable, :authenticatable, :recoverable, :rememberable, :trackable, :validatable, :lockable, :autosigninable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation
end
