require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ticketmaster::Provider::Trac::Project" do

  before(:all) do 
    @project_id = 'testrepo'  
  end

  before(:each) do
    @ticketmaster = TicketMaster.new(:trac, {:username => 'cored', :password => 'afdzk', :url => 'http://trac.edgewall.org/demo-0.11'})
    @klass = TicketMaster::Provider::Trac::Project
  end

  it "should be able to load all projects" do
    @ticketmaster.projects.should be_an_instance_of(Array)
    @ticketmaster.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects from an array of id's" do 
    @projects = @ticketmaster.projects([@project_id])
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects from attributes" do 
    @projects = @ticketmaster.projects(:url => 'http://trac.edgewall.org')
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

end
