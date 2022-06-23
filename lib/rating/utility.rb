module Rating
  module Utility

    def initial_rating_deviation(old_deviation = 1)
      potential_deviation = Math.sqrt(old_deviation + 0.96)
      [potential_deviation, 2].min
    end

    def new_rating_deviation(old_deviation)
      initial_rating_deviation(old_deviation)
    end


  end
end
