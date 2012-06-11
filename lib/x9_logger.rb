# -*- encoding : utf-8 -*-
require 'logger'
require 'active_support'
require 'x9_logger/version'

module X9Logger
  module Config
    def err= file_path
      ensure_path_exists file_path
      @err = Logger.new file_path
      @err.datetime_format = "%Y-%m-%d %H:%M:%S"
      @err.formatter = proc do |severity, datetime, progname, msg|
        "\n#{datetime} [#{sprintf "%5s", severity}] #{$$} #{progname}: #{msg}\n"
      end
    end

    def err
      @err || out
    end

    def out
      @out ||= out=(STDOUT)
    end

    def out= file_path
      ensure_path_exists file_path
      @out = Logger.new file_path
      @out.datetime_format = "%Y-%m-%d %H:%M:%S"
      @out.formatter = proc do |severity, datetime, progname, msg|
        "#{datetime} [#{sprintf "%5s", severity}] #{$$} #{progname}: #{msg}\n"
      end
    end

    private
    def ensure_path_exists file_path
      FileUtils.mkdir_p(File.expand_path "..", file_path) if file_path.kind_of? String
    end
  end
end

module X9Logger
  class << self
    include Config

    def new &block
      yield self
      self
    end

    %w(debug info warn).each do |severity|
      define_method severity do |obj|
        output_to @out, severity, obj
      end
    end

    %w(error fatal).each do |severity|
      define_method severity do |obj|
        output_to @err, severity, obj
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
