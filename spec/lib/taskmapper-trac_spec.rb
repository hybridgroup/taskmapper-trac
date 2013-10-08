require 'spec_helper'

describe "TaskMapper::Provider::Trac" do
  before(:each) do
    @taskmapper = TaskMapper.new(:trac, {:username => 'cored', :password => 'afdzk', :url => 'http://trac.edgewall.org/demo-0.11'})
  end

  it "should be able to instantiate a new instance" do
    @taskmapper.should be_an_instance_of(TaskMapper)
    @taskmapper.should be_a_kind_of(TaskMapper::Provider::Trac)
  end

end
