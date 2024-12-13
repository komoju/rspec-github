# frozen_string_literal: true

require 'rspec/core'
require 'rspec/core/formatters/base_formatter'
require 'rspec/github/notification_decorator'

module RSpec
  module Github
    class Formatter < RSpec::Core::Formatters::BaseFormatter
      RSpec::Core::Formatters.register self, :example_failed, :seed

      def example_failed(failure)
        notification = NotificationDecorator.new(failure)

        output.puts "\n::error file=#{notification.path},line=#{notification.line}::#{notification.annotation}"
      end

      def seed(notification)
        return unless notification.seed_used?

        output.puts notification.fully_formatted
      end
    end
  end
end
