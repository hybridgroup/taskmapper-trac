require 'spec_helper'

describe TaskMapper::Provider::Trac::Project do
  let(:project_id) { 'cored-project' }
  let(:tm) { create_instance('cored', 'afdzk', 'http://trac.edgewall.org/demo-0.11') }
  let(:klass) { TaskMapper::Provider::Trac::Project }

  it "should be able to load all projects" do
    tm.projects.should be_an_instance_of(Array)
    tm.projects.first.should be_an_instance_of(klass)
  end

  it "should be able to load all projects from an array of id's" do
    projects = tm.projects([project_id])
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(klass)
    projects.first.id.should == 1
  end

  it "should be able to load all projects from attributes" do
    projects = tm.projects(:url => 'http://trac.edgewall.org')
    projects.should be_an_instance_of(Array)
    projects.first.should be_an_instance_of(klass)
  end

  it "should be able to load projects using the find method" do
    tm.project.should == klass
    tm.project.find(project_id).should be_an_instance_of(klass)
  end

  it "should be able to find a project by name" do
    project = tm.project(project_id)
    project.should be_an_instance_of(klass)
    project.name.should == project_id
  end
end
