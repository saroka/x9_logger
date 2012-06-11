require 'spec_helper'

describe X9Logger do
  subject {
    X9Logger.new do |l|
      l.out = 'out.log'
      l.err = 'err.log'
    end
  }

  after :each do
    FileUtils.rm 'out.log'
    FileUtils.rm 'err.log'
  end

  it 'receives a block with configuration of out and err' do
    subject.out.should_not be_nil
    subject.err.should_not be_nil
  end

  %w(debug info warn).each do |level|
    it "logs #{level} level to out device" do
      subject.send level, "#{level} level"
      File.read('out.log').should include("#{level} level")
    end
  end

  %w(error fatal).each do |level|
    it "logs #{level} level to err device" do
      subject.send level, "#{level} level"
      File.read('err.log').should include("#{level} level")
    end
  end
end