require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CommentUtil" do 

  before(:each) do 
    trac = {:url => 'https://pl3.projectlocker.com/CapLinked/Website/trac/', :username => 'ron@hybridgroup.com', :password => 'password'}
    @comment_util = CommentUtil.new(1, trac)
  end

  it "should return all comments for a ticket" do 
    pending("Fix me")
    @comment_util.comments.should be_instance_of(Array)
  end
end
