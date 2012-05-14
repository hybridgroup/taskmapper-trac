module TaskMapper::Provider
  module Trac
    # The comment class for taskmapper-yoursystem
    #
    # Do any mapping between taskmapper and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TaskMapper::Provider::Base::Comment
      # declare needed overloaded methods here

      def initialize(*object)
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:id => object[:id],
              :author => object.author,
              :body => object.body,
              :ticket_id => object.ticket_id,
              :created_at => object.created_at,
              :updated_at => object.updated_at}
          else
            hash = object
          end
          super(hash)
        end
      end

      def created_at
        begin
          Time.parse(self[:created_at])
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          Time.parse(self[:updated_at])
        rescue
          self[:updated_at]
        end
      end

      def id
        self[:id]
      end

      def self.find_by_attributes(project_id, ticket_id, attributes = {})
        comments = self.find_all(ticket_id)
        search_by_attribute(comments, attributes)
      end

      def self.find(project_id, ticket_id, *options)
        if options[0].first.is_a? Array
          self.find_all(ticket_id).select do |comment|
            comment if options[0].any? { |id| id == comment.id }
          end
        elsif options[0].first.is_a? Hash
          self.find_by_attributes(project_id, ticket_id, options[0].first)
        else
          self.find_all(ticket_id)
        end
      end

      def self.find_by_id(project_id, ticket_id, id)
        self.find_all(ticket_id).select { |comment| comment[:id] == id }.first
      end

      def self.find_all(ticket_id)
        comments = CommentUtil.new(ticket_id,TaskMapper::Provider::Trac.api).comments
        comments.compact.collect do |comment| 
          TaskMapper::Provider::Trac::Comment.new comment 
        end
      end

    end
  end
end
