class List < ApplicationRecord
    has_many :tasks, -> { order("completed").order("title") }, dependent: :destroy
    belongs_to :user
end
