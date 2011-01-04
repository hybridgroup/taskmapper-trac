require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac::Ticket" do
  before(:all) do 
    @project_id = 'demo-0.11'
  end

  before(:each) do 
    @ticketmaster = TicketMaster.new(:trac, {:url => 'http://pl3.projectlocker.com/cored/testrepo/trac', :username => 'george.rafael@gmail.com', :password => '123456'})
    @project = @ticketmaster.project(@project_id)
    @klass = TicketMaster::Provider::Trac::Ticket
  end

  it "should be able to load all tickets" do 
    @project.tickets.should be_an_instance_of(Array)
    @project.tickets.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all tickets based on array of id's" do
    @tickets = @project.tickets([1])
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.summary.should == 'test'
  end

  it "should be able to load all tickets using attributes" do
    @tickets = @project.tickets(:status => "!closed")
    @tickets.should be_an_instance_of(Array)
    @tickets.first.should be_an_instance_of(@klass)
    @tickets.first.summary.should == 'test'
  end

  it "should return the ticket class" do
    @project.ticket.should == @klass
  end

  it "should be able to load a single ticket based on attributes"  do
    @ticket = @project.ticket(:status => "!closed")
    @ticket.should be_an_instance_of(@klass)
    @ticket.summary.should == 'test'
  end

 # it "should be able to create a new ticket" do
 #   @ticket = @project.ticket!({:summary => 'Testing', :description => "Here we go"})
 #   @ticket.should be_an_instance_of(@klass)
 # end

end
