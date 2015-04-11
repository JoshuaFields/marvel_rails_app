class Character < ActiveRecord::Base

  validates :character_name, presence: true

end
