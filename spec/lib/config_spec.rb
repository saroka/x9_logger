# -*- encoding : utf-8 -*-
require 'spec_helper'

module X9Logger
  describe Config do
    describe 'out=' do
      it 'receives a file_path and creates a Logger instance for it'
      it 'receives an IO object and creates a Logger instance for it'
      it 'sets %Y-%m-%d %H:%M:%S as default date format'
      it 'sets a formatter'
    end

    describe 'out' do
      it 'returns the Logger instance created'
      it 'returns a Logger instance for STDOUT when neither a file_path nor an IO object was provided'
    end

    describe 'err=' do
      it 'receives a file_path and creates a Logger instance for it'
      it 'receives an IO object and creates a Logger instance for it'
      it 'sets %Y-%m-%d %H:%M:%S as default date format'
      it 'sets a formatter'
    end

    describe 'err' do
      it 'returns the Logger instance created'
      it 'returns the same Logger instance for out when neither a file_path nor an IO object was provided'
    end
  end
end