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
    @ticket_id = ticket_id
  end

  def comments
    comment_id = 0
    @doc.css('h3.change a.timeline').collect do |value|
      body = @doc.css('div.comment p')
      comment_id += 1
      build_comment_hash(value, comment_id, body[comment_id-1].text)
    end
  end

  private
  def build_comment_hash(value, comment_id, body)
    comment = {}
    comment[:created_at] = date_from_attributes(value)
    comment[:updated_at] = date_from_attributes(value)
    comment[:ticket_id] = @ticket_id
    comment[:body] = body
    comment[:id] = comment_id
    comment
  end

  def date_from_attributes(value)
    value.attributes["title"].value.split(/\s/)[0]
  end
end


