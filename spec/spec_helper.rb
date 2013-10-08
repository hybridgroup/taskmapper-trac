require 'taskmapper'
require 'taskmapper-trac'
require 'rspec'
require 'fakeweb'

FakeWeb.allow_net_connect = false

def username
  "george.rafael@gmail.com"
end

def password
  '123456'
end

def base_uri
  'http://pl3.projectlocker.com/cored/testrepo/trac'
end

def create_instance(u = username, p = password, url = base_uri)
  TaskMapper.new :trac, :username => u, :password => p, :url => url
end
