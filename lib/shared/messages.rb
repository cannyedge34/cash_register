# frozen_string_literal: true

module Shared
  module Messages
    ARGUMENTS_COUNT_ERROR = 'Cannot proceed with more than one argument.'
    NO_ARGUMENTS_ERROR = 'Can not proceed without argument.'
    EMPTY_CODES_ERROR = 'At least one item id needed.'
    EMPTY_SPACES_ERROR = 'There should be no spaces between commas, example: "GR1,GR1,GR1"'
    NOT_FOUND_ITEMS_ERROR = 'Received items codes do not exist in the database!'
    ONE = 1
    EXPECTED_TOTAL_PRICE = 'Expected total price'
    ONE_HUNDRED = 100.0
    ZERO = 0.0

    def self.print(text)
      puts text
    end
  end
end
