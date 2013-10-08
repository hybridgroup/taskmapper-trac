require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe TaskMapper::Provider::Trac::Comment do
  before(:each) do 
    @taskmapper = TaskMapper.new(:trac, {:username => 'george.rafael@gmail.com', :password => '123456', :url => 'http://pl3.projectlocker.com/cored/testrepo/trac'})
    @project = @taskmapper.projects.first
    @project.stub(:tickets).and_return([TaskMapper::Provider::Trac::Ticket.new])
    @ticket = @project.tickets.first
    @klass = TaskMapper::Provider::Trac::Comment
    @comment_1 = @klass.new(:id => 1)
    @comment_2 = @klass.new(:id => 2)
    @comments = [@comment_1, @comment_2]
    @ticket.stub(:comments).and_return(@comments)
    @ticket.stub(:comment).and_return(@comment_2)
  end

  it "should load all comments from a ticket" do 
    @ticket.comments.should be_an_instance_of(Array)
    @ticket.comments.first.should be_an_instance_of(@klass)
  end

  it "should be able to load all comments based on id's" do
    @comments = @ticket.comments([1,2])
    @comments.should be_an_instance_of(Array)
    @comments.first.id.should == 1
    @comments.last.id.should == 2
    @comments[1].should be_an_instance_of(@klass)
  end

  it "should be able to load comments throught attributes" do 
    @comments = @ticket.comments(:ticket_id => 1)
    @comments.should be_an_instance_of(Array)
    @comments.first.id.should == 1
    @comments.last.id.should == 2
    @comments[1].should be_an_instance_of(@klass)
  end

  it "should be able to load a comment based on id" do
    @comment = @ticket.comment(2)
    @comment.should be_an_instance_of(@klass)
    @comment.id.should == 2
  end

  it "should return the comment class" do
    @ticket.comment.should be_an_instance_of(@klass)
  end

  it "should be able to load a comment using attributes" do
    @comment = @ticket.comment(:ticket_id => 2)
    @comment.should be_an_instance_of(@klass)
    @comment.id.should == 2
  end

end
