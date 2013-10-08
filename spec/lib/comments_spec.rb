require 'spec_helper'

describe TaskMapper::Provider::Trac::Comment do
  let(:tm) { create_instance }
  let(:project) { tm.projects.first }
  let(:ticket) { project.tickets.first }
  let(:klass) { TaskMapper::Provider::Trac::Comment }
  let(:comment_1) { klass.new(:id => 1) }
  let(:comment_2) { klass.new(:id => 2) }
  let(:comments) { [comment_1, comment_2] }

  before do
    project.stub(:tickets).and_return([TaskMapper::Provider::Trac::Ticket.new])
    ticket.stub(:comments).and_return(comments)
    ticket.stub(:comment).and_return(comment_2)
  end

  it "should load all comments from a ticket" do
    ticket.comments.should be_an_instance_of(Array)
    ticket.comments.first.should be_an_instance_of(klass)
  end

  it "should be able to load all comments based on id's" do
    comments = ticket.comments([1,2])
    comments.should be_an_instance_of(Array)
    comments.first.id.should == 1
    comments.last.id.should == 2
    comments[1].should be_an_instance_of(klass)
  end

  it "should be able to load comments throught attributes" do
    comments = ticket.comments(:ticket_id => 1)
    comments.should be_an_instance_of(Array)
    comments.first.id.should == 1
    comments.last.id.should == 2
    comments[1].should be_an_instance_of(klass)
  end

  it "should be able to load a comment based on id" do
    comment = ticket.comment(2)
    comment.should be_an_instance_of(klass)
    comment.id.should == 2
  end

  it "should return the comment class" do
    ticket.comment.should be_an_instance_of(klass)
  end

  it "should be able to load a comment using attributes" do
    comment = ticket.comment(:ticket_id => 2)
    comment.should be_an_instance_of(klass)
    comment.id.should == 2
  end
end
