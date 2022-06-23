module Rating
  module Utility

    def initial_rating_deviation(old_deviation = 1)
      potential_deviation = Math.sqrt(old_deviation + 0.96)
      [potential_deviation, 2].min
    end

    def new_rating_deviation(old_deviation)
      initial_rating_deviation(old_deviation)
    end

    def q
      (Math.log10(10) / Math.log10(2.71828)) / 400 # 0.0057565
    end

    def g_function(opponent_rating_dev = initial_rating_deviation)
      1 / Math.sqrt(1 + ((3 * (q**2) * (opponent_rating_dev**2)) / (Math::PI**2)))
    end

    def e_function(my_rating, opponent_rating, opponent_rating_dev)
      1 / (1 + (10 * ((g_function(opponent_rating_dev) * (my_rating - opponent_rating)) / -400)))
    end

    def d_squared(my_rating, opponent_rating, opponent_rating_dev = initial_rating_deviation)
      # m = 1

      1 / (q**2 * (g_function**2) *
        e_function(my_rating,opponent_rating, opponent_rating_dev) *
        (1 - e_function(my_rating, opponent_rating, opponent_rating_dev)))
    end

    def new_rating(
      current_rating,
      opponent_rating,
      current_rating_dev = initial_rating_deviation,
      opponent_rating_dev = initial_rating_deviation)

      Math.sqrt((1 / (new_rating_deviation(current_rating_dev)**2) +
        (1 / d_squared(current_rating, opponent_rating,opponent_rating_dev)))**-1)
    end

  end
end
