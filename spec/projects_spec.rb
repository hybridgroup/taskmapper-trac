require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Trac::Project do

  before(:all) do 
    @project_id = 'cored-project'  
  end

  before(:each) do
    @taskmapper = TaskMapper.new(:trac, {:username => 'cored', :password => 'afdzk', :url => 'http://trac.edgewall.org/demo-0.11'})
    @klass = TaskMapper::Provider::Trac::Project
  end

  it "should be able to load all projects" do
    @taskmapper.projects.should be_an_instance_of(Array)
    @taskmapper.projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all projects from an array of id's" do 
    @projects = @taskmapper.projects([@project_id])
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
    @projects.first.id.should == 1 
  end

  it "should be able to load all projects from attributes" do 
    @projects = @taskmapper.projects(:url => 'http://trac.edgewall.org')
    @projects.should be_an_instance_of(Array)
    @projects.first.should be_an_instance_of(@klass)
  end

  it "should be able to load projects using the find method" do
    @taskmapper.project.should == @klass
    @taskmapper.project.find(@project_id).should be_an_instance_of(@klass)
  end

  it "should be able to find a project by name" do
    @project = @taskmapper.project(@project_id)
    @project.should be_an_instance_of(@klass)
    @project.name.should == @project_id
  end

end
