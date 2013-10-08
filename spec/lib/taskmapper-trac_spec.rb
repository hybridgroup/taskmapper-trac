require 'spec_helper'

describe TaskMapper::Provider::Trac do
  let(:tm) { create_instance }

  describe "#new" do
    it "creates a new TaskMapper instance" do
      expect(tm).to be_a TaskMapper
    end

    it "can be explicitly called as a provider" do
      tm = TaskMapper::Provider::Trac.new(
        :username => username,
        :password => password,
        :url => base_uri
      )

      expect(tm).to be_a TaskMapper
    end
  end
end
