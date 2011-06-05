require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac" do
  before(:each) do 
    @ticketmaster = TicketMaster.new(:trac, {:username => 'ticketmaster', :password => '000000', :url => 'here.com'})
  end

  it "should be able to instantiate a new instance" do
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::Trac)
  end

  it "should be able to validate authentication" do 
    @ticketmaster.valid?.should be_true
  end

end
