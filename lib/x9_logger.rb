# -*- encoding : utf-8 -*-
require 'logger'
require 'fileutils'
require 'active_support'

require_relative 'x9_logger/version'
require_relative 'x9_logger/config'
require_relative 'x9_logger/log'

module X9Logger
  class << self
    def new &block
      X9Logger::Log.new &block
    end
  end
end
