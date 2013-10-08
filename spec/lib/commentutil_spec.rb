require 'spec_helper'

describe CommentUtil do
  let(:trac) do
    {
      :url => 'http://localhost/trac',
      :username => 'username',
      :password => 'password'
    }
  end

  let(:comment_util) do
    CommentUtil.new(
      1, trac, Nokogiri::HTML(File.open('spec/commentutils-data.html'))
    )
  end

  describe "#comments" do
    let(:comments) { comment_util.comments }

    it "should return all comments for a ticket" do
      expect(comments).to be_an Array
    end
  end
end
