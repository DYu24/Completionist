class List < ApplicationRecord
    has_many :tasks, -> { order("completed").order("title") }, dependent: :destroy
    belongs_to :user

    def percent_complete
        if self.tasks.length == 0
            return 0
        end

        completed_tasks = self.tasks.select { |t| t.completed? }
        return (completed_tasks.length.to_f / self.tasks.length.to_f * 100).to_i
    end
end
