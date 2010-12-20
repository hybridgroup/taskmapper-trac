require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::TracProvider" do
  
  it "should be able to instantiate a new instance" do
    @ticketmaster = TicketMaster.new(:trac, {:username => 'ticketmaster', :password => '000000', :url => 'here.com'})
    @ticketmaster.should be_an_instance_of(TicketMaster)
    @ticketmaster.should be_a_kind_of(TicketMaster::Provider::TracProvider)
  end
  
end
