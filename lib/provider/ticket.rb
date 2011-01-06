module TicketMaster::Provider
  module Trac
    # Ticket class for ticketmaster-yoursystem
    #

    class Ticket < TicketMaster::Provider::Base::Ticket
      # declare needed overloaded methods here

      API = TracAPI
      def initialize(*object)
        if object.first
          object = object.first
          unless object.is_a? Hash
            @system_data = {:client => object}
            hash = {:id => object.id,
              :severity => object.severity,
              :milestone => object.milestone,
              :status => object.status,
              :type => object.type, 
              :priority => object.priority,
              :version => object.version,
              :reporter => object.reporter,
              :owner => object.owner,
              :cc => object.cc,
              :summary => object.summary,
              :description => object.description,
              :keywords => object.keywords,
              :created_at => object.created_at,
              :updated_at => object.updated_at}
          else
            hash = object
          end
          super(hash)
        end
      end

      def self.find_by_id(id)
        self.new API.api.tickets.get id
      end

      def self.create(*options)
        mandatory = options.shift
        attributes = {}
        attributes ||= options.shift
        begin
          self.find_by_id API.api.tickets.create(mandatory[:summary], mandatory[:description], attributes)
        rescue
          self
        end
      end

      def comments(*options)
        comments = CommentUtil.new(self.id).comments.collect { |comment| TicketMaster::Provider::Trac::Comment.new comment }
        if options.first.is_a? Array
          comments.select do |comment|
            comment if options.first.any? { |id| id == comment.id }
          end
        elsif options.first.is_a? Hash
          hash = options.first
          comments.select do |key, value|
            hash[key] == value
          end
        else
          comments
        end
      end

      def comment(*options)
        comments = CommentUtil.new(self.id).comments.collect { |comment| TicketMaster::Provider::Trac::Comment.new comment }
        if options.empty?
          TicketMaster::Provider::Trac::Comment.new
        elsif options.first.is_a? Fixnum
          comments.select { |comment| comment[:id] == options.first }.first
        elsif options.first.is_a? Hash
          comments.select do |key, value| 
            options.first[key] == value
          end.first
        end
      end

      def comment!
        warn "Trac doesn't support comments"
        [] 
      end
    end
  end
end
