# code to communicate with your backend goes here...

class TracAPI
  def initialize(trac, username, url)
    @@api = trac
    @@username = username
    @@url = url
  end

  def self.api
    @@api
  end

  def self.url
    @@url
  end

  def self.username
    @@username
  end
end


