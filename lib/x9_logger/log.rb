# -*- encoding : utf-8 -*-
module X9Logger
  class Log
    include Config

    def initialize &block
      yield self
    end

    %w(debug info warn).each do |severity|
      define_method severity do |obj|
        output_to out, severity, obj
      end
    end

    %w(error fatal).each do |severity|
      define_method severity do |obj|
        output_to err, severity, obj
      end
    end

    private
    def output_to device, severity, obj
      if obj.kind_of? Exception
        backtrace = bc.clean(obj.backtrace).join "\n"
        device.send severity, "#{obj.message}\n#{backtrace}"
      else
        device.send severity, obj
      end
    end

    def bc
      @bc ||= ActiveSupport::BacktraceCleaner.new.tap do |bc|
        bc.add_silencer { |line| line =~ %r{passenger|webrick|mongrel} }
      end
    end
  end
end
