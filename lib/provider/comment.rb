module TicketMaster::Provider
  module Trac
    # The comment class for ticketmaster-yoursystem
    #
    # Do any mapping between Ticketmaster and your system's comment model here
    # versions of the ticket.
    #
    class Comment < TicketMaster::Provider::Base::Comment
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

      def self.find_all(ticket_id)
        comments = CommentUtil.new(ticket_id,TicketMaster::Provider::Trac.api).comments
        puts comments.inspect
        unless comments.empty?
          comments = comments.collect { |comment| TicketMaster::Provider::Trac::Comment.new comment }
        end
        comments
      end

    end
  end
end
