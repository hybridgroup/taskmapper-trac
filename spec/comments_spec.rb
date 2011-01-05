require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac::Comment" do
  before(:each) do 
    @ticketmaster = TicketMaster.new(:trac, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'http://pl3.projectlocker.com/cored/testrepo/trac'})
    @project = @ticketmaster.projects.first
    @ticket = @project.tickets.first
    @klass = TicketMaster::Provider::Trac::Comment
  end

  it "should load all comments from a ticket" do 
    @ticket.comments.should be_an_instance_of(Array)
    @ticket.comments.first.should be_an_instance_of(@klass)
  end
<<<<<<< HEAD
=======

  it "should be able to load all comments based on id's" do
    @comments = @ticket.comments([1,2])
    @comments.should be_an_instance_of(Array)
    @comments.first.id.should == 1
    @comments.last.id.should == 2
    @comments[1].should be_an_instance_of(@klass)
  end
>>>>>>> adding-comments
end
