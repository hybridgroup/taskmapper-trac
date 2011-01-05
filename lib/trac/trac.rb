# code to communicate with your backend goes here...

class TracAPI
  def initialize(trac, url, username, password)
    @@api = trac
    @@username = username
    @@url = url
    @@password = password
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

  def self.password
    @@password
  end
end

class CommentUtil

  def initialize(ticket_id)
    @doc = Nokogiri::HTML(open("#{TracAPI.url}/ticket/#{ticket_id}", :http_basic_authentication=>[TracAPI.username, TracAPI.password]))
  end

  def comments
    @doc.css('div.change').collect do |value|
      value.content
    end
  end
end


