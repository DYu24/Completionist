class List < ApplicationRecord
    has_many :tasks, -> { order("completed").order("title") }, dependent: :destroy
    belongs_to :user

    def number_completed
        return self.tasks.select { |t| t.completed? }.length
    end

    def percent_complete
        if self.tasks.length == 0
            return 0
        end

        return (self.number_completed.to_f / self.tasks.length.to_f * 100).to_i
    end

    def truncated_description
        max_length = 80
        str = self.description
        return str && str.length > max_length ? "#{str[0...max_length]}..." : str
    end
end
