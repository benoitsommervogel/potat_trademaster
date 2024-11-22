class RatesController < ApplicationController

  # GET /daily_rates
  def get_daily_rates
    @rates = Rate.where(time: params[:date].to_date.all_day).order(:time)

    render json: @rates, only: [:time, :value]
  end

  # GET /daily_benefits
  def get_best_benefit
    @rates = Rate.where(time: params[:date].to_date.all_day).order(:value)
    best_rate = 0

    # we pick the best differences until we find one that meets the qualification of
    # lowest price happening before highest price
    @rates.each do |buying_rate|
      @rates.reverse_each do |selling_rate|

        # we found a valid transaction
        if buying_rate.time < selling_rate.time
          best_rate = 100 * (selling_rate.value - buying_rate.value)
          break
        end

        # from this point on, no transaction is rentable
        break if buying_rate.value >= selling_rate.value
      end

      # the best transaction has been found
      break if best_rate > 0
    end

    render json: {value: "#{best_rate}€"}
  end

end
