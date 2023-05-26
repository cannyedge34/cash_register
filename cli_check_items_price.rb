#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'lib/shared/db/in_memory'
require_relative 'lib/items/infrastructure/cli/price_checker_controller'

# these data should already exist. It is not correct to access the seed from this use case
Shared::Db::InMemory.instance.seed

Items::Infrastructure::Cli::PriceCheckerController.new(params: ARGV).call
