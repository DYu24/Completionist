class Task < ApplicationRecord
    belongs_to :list

    def overdue?
        date_passed = !self.due_date.nil? && self.due_date.past?
        time_passed = !self.due_time.nil? && self.due_time.past?
        return date_passed || (date_passed && time_passed)
    end
end
