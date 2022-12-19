class Planet < ApplicationRecord
    has_many :missions, dependent: :destroy
    has_many :planets, through: :missions
end
