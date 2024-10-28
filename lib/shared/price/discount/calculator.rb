# frozen_string_literal: true

require_relative './calculators_data'

module Shared
  module Price
    module Discount
      class Calculator
        def initialize(discounts_calculators_data: Shared::Price::Discount::CalculatorsData.build)
          @discounts_calculators_data = discounts_calculators_data
        end

        def call(record, quantity, pricing_rule = nil, calculable = nil)
          discount_calculator_constant = discounts_calculators_data[calculable&.slug]

          return Shared::Messages::ZERO unless pricing_rule && discount_calculator_constant

          options = { record:, quantity:, pricing_rule: }

          discount_calculator_constant&.new(options:)&.call
        end

        private

        attr_reader :discounts_calculators_data
      end
    end
  end
end
