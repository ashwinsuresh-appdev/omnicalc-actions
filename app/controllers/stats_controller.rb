class StatsController < ApplicationController
  def stats
    @numbers = params.fetch("list_of_numbers").gsub(",", "").split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.length
    
    min_num = @numbers.first
    @numbers.each { |n| min_num = n if n < min_num }

    @minimum = min_num

    max_num = @numbers.first 
    @numbers.each { |n| max_num = n if n > max_num }

    @maximum = max_num

    @range = max_num - min_num

    # Median
    # ======

    def median(numbers)
      sorted = @numbers.sort
      len = sorted.length
      (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
    end

    @median = median(@numbers)

    @sum = @numbers.inject(0, :+)

    @mean = @sum / @numbers.length

    # Variance
    # ========

    def variance(numbers)
      var_sum = @numbers.collect{|n| (n-@mean)**2}.inject(:+)
      var_sum / @numbers.length
    end

    @variance = variance(@numbers)

    @standard_deviation = Math.sqrt(@variance)

    # Mode
    # ====

    def mode(numbers)
      @numbers.group_by{ |e| e }.group_by{ |k, v| v.length }.max.pop.map{ |e| e.shift }.sort
    end

    @mode = mode(@numbers).join(", ")

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("stats_templates/stats.html.erb")
  end

  def stats_form
    render("stats_templates/stats_form.html.erb")
  end
  
end
