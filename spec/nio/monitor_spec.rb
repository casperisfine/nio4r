require 'spec_helper'

describe NIO::Monitor do
  let :readable_pipe do
    pipe, peer = IO.pipe
    peer << "data"
    pipe
  end

  # let :unreadable_pipe do
  #   pipe, _ = IO.pipe
  #   pipe
  # end

  let :selector do
    NIO::Selector.new
  end

  # Monitors are created by registering IO objects or channels with a selector
  subject { selector.register(readable_pipe, :r) }

  it "knows its interests" do
    subject.interests.should == :r
  end

  it "stores arbitrary values" do
    subject.value = 42
    subject.value.should == 42
  end

  it "closes" do
    subject.should_not be_closed
    subject.close
    subject.should be_closed
  end
end
