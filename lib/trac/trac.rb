# code to communicate with your backend goes here...

class CommentUtil

  def initialize(ticket_id, trac, doc = nil)
    @doc = doc || Nokogiri::HTML(open("#{trac[:url]}/ticket/#{ticket_id}", :http_basic_authentication=>[trac[:username], trac[:password]]))
    @ticket_id = ticket_id
  end

  def comments
    comment_id = 0
    @doc.css('h3.change a.timeline').collect do |value|
      body = @doc.css('div.comment p')
      authors = @doc.css('h3.change')
      comment_id += 1
      unless body[comment_id-1].nil? || authors[comment_id-1].nil?
        build_comment_hash(value, comment_id, body[comment_id-1].text, authors[comment_id-1].content)
      end
    end
  end

  private
  def build_comment_hash(value, comment_id, body, author)
    comment = {}
    comment[:created_at] = date_from_attributes(value)
    comment[:updated_at] = date_from_attributes(value)
    comment[:ticket_id] = @ticket_id
    comment[:body] = body
    comment[:author] = normalize_author_field(author)
    comment[:id] = comment_id
    comment
  end

  def normalize_author_field(author)
    author.strip.split(/by/)[1]
  end

  def date_from_attributes(value)
    value.attributes["title"].value.split(/\s/)[0]
  end
end


