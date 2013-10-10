require 'spec_helper'

describe TaskMapper::Provider::Trac::Project do
  let(:project_id) { 'cored-project' }
  let(:tm) { create_instance('cored', 'afdzk', 'http://trac.edgewall.org/demo-0.11') }
  let(:project_class) { TaskMapper::Provider::Trac::Project }

  describe "#projects" do
    context "without arguments" do
      let(:projects) { tm.projects }

      it "returns an array of all projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end

    context "with an array of project IDs" do
      let(:projects) { tm.projects [project_id] }

      it "returns an array of matching projects" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
        expect(projects.first.name).to eq project_id
      end
    end

    context "with a hash of project attributes" do
      let(:projects) { tm.projects :url => 'http://trac.edgewall.org' }

      it "returns an array containing the relevant project" do
        expect(projects).to be_an Array
        expect(projects.first).to be_a project_class
      end
    end
  end

  describe "#project" do
    context "with a project ID" do
      let(:project) { tm.project project_id }

      it "finds the requested project" do
        expect(project).to be_a project_class
        expect(project.name).to eq project_id
      end
    end

    describe "#find" do
      context "with a project ID" do
        let(:project) { tm.project.find project_id }

        it "finds the requested project" do
          expect(project).to be_a project_class
          expect(project.name).to eq project_id
        end
      end
    end
  end
end
