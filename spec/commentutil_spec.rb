require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CommentUtil" do 

  before(:each) do 
    trac = {:url => 'http://localhost/trac', :username => 'username', :password => 'password'}
    @comment_util = CommentUtil.new(1, trac, Nokogiri::HTML(File.open('spec/commentutils-data.html')))
  end

  it "should return all comments for a ticket" do 
    @comment_util.comments.should be_instance_of(Array)
    @comment_util.comments.first[:comment_id] == 1
  end
end
