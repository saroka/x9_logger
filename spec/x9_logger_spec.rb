require 'spec_helper'

describe X9Logger do
  let(:out_log) { 'out.log' }
  let(:err_log) { 'err.log' }

  subject {
    X9Logger.new do |l|
      l.out = out_log
      l.err = err_log
    end
  }

  after :each do
    FileUtils.rm out_log if File.exists?(out_log)
    FileUtils.rm err_log if File.exists?(err_log)
  end

  it 'receives a block with configuration of out and err' do
    subject.out.should_not be_nil
    subject.err.should_not be_nil
  end

  it 'output error to out when err is not provided' do
    logger = X9Logger.new {|l| l.out = out_log}
    logger.error 'error level'
    File.read(out_log).should include("error level")
  end

  %w(debug info warn).each do |level|
    it "logs #{level} level to out device" do
      subject.send level, "#{level} level"
      File.read(out_log).should include("#{level} level")
    end
  end

  %w(error fatal).each do |level|
    it "logs #{level} level to err device" do
      subject.send level, "#{level} level"
      File.read(err_log).should include("#{level} level")
    end
  end
end