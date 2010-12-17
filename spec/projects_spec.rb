require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac::Project" do

  before(:all) do
    @klass = TicketMaster::Provider::Trac::Project
  end

  before(:each) do
    @trac = TicketMaster::Provider::Trac.new('http://trac.edgewall.org',{:login => 'cored', :password => 'jdudk'})
  end

  it "should be able to load all projects" do
    projects = @trac.projects
  end
end
