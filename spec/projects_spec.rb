require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac::Project" do

  before(:all) do
    @klass = TicketMaster::Provider::Trac::Project
  end

  before(:each) do
    @trac = TicketMaster.new(:trac, {:username => 'cored', :password => 'afdzk', :url => 'http://trac.edgewall.org/demo-0.11'})
  end

  it "should be able to load all projects" do
    projects = @trac.projects
  end
end
