require 'spec_helper'

describe X9Logger do

  let(:output) {
    StringIO.new
  }

  let(:errput) {
    StringIO.new
  }

  context 'logger with out and err configured' do
    subject {
      X9Logger.new do |l|
        l.out = output
        l.err = errput
      end
    }

    %w(debug info warn).each do |level|
      it "logs #{level} level to out device" do
        subject.send level, "#{level} level"
        output.rewind
        output.read.should include("#{level} level")
        errput.rewind
        errput.read.should_not include("#{level} level")
      end
    end

    %w(error fatal).each do |level|
      it "logs #{level} level to err device" do
        subject.send level, "#{level} level"
        output.rewind
        output.read.should_not include("#{level} level")
        errput.rewind
        errput.read.should include("#{level} level")
      end
    end
  end

  context 'logger with only out configured' do
    subject {
      X9Logger.new do |l|
        l.out = output
      end
    }

    %w(debug info warn error fatal).each do |level|
      it "logs #{level} level to out device" do
        subject.send level, "#{level} level"
        output.rewind
        output.read.should include("#{level} level")
      end
    end
  end
end