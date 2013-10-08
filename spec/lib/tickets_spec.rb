require 'spec_helper'

describe TaskMapper::Provider::Trac::Ticket do
  let(:tm) { TaskMapper.new(:trac, {:url => 'http://pl3.projectlocker.com/cored/testrepo/trac', :username => 'george.rafael@gmail.com', :password => '123456'}) }
  let(:ticket_class) { TaskMapper::Provider::Trac::Ticket }
  let(:project_id) { 'demo-0.11' }
  let(:project) { tm.project project_id }
  let(:ticket_1) { ticket_class.new(:summary => 'test', :status => 'open') }
  let(:tickets) { [ticket_1] }

  before(:each) do 
    project.stub(:tickets).and_return(tickets)
    project.stub(:ticket).and_return(ticket_1)
    project.stub(:ticket!).and_return(ticket_class.new)
  end

  describe "Retrieving tickets" do 
    context :tickets  do 
      subject { project.tickets }
      it { should be_an_instance_of Array }
      context :first do 
        subject { project.tickets.first }
        it { should be_an_instance_of ticket_class }
      end
    end

    context "#tickets with an array of id's" do
      let(:tickets_with_ids) { project.tickets [1] }
      subject { tickets_with_ids }
      it { should be_an_instance_of Array }
      context :first do 
        subject { tickets_with_ids.first }
        it { should be_an_instance_of ticket_class }
        its(:summary) { should == 'test' }  
      end
    end

    context "#tickets with attributes" do 
      let(:tickets_with_attributes) { project.tickets(:status => "!closed") }
      subject { tickets_with_attributes }
      it { should be_an_instance_of Array }
      context :first do 
        subject { tickets_with_attributes.first }
        it { should be_an_instance_of ticket_class }
        its(:summary) { should == 'test' }
      end
    end

    context :ticket do 
      subject { project.ticket(:status => "!closed") }
      it { should be_an_instance_of ticket_class }
      its(:summary) { should == 'test' }
    end

  end

  describe "Creating and updating tickets" do 
    context :ticket! do 
      subject { project.ticket!({:summary => 'Testing', :description => "Here we go"}) }
      it { should be_an_instance_of ticket_class }
    end
  end

end
