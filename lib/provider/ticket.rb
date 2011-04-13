module TicketMaster::Provider
  module Trac
    # Ticket class for ticketmaster-yoursystem
    #

    class Ticket < TicketMaster::Provider::Base::Ticket
      # declare needed overloaded methods here

      def initialize(*object)
        if object.first
          args = object
          object = args.shift
          project_id = args.shift
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
              :assignee => object.owner,
              :requestor => object.reporter,
              :title => object.summary,
              :project_id => project_id,
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

      def created_at
        begin
          normalize_datetime(self[:created_at]) 
        rescue
          self[:created_at]
        end
      end

      def updated_at
        begin
          normalize_datetime(self[:updated_at])
        rescue
          self[:updated_at]
        end
      end

      def self.find_by_id(id, project_id)
        trac = TicketMaster::Provider::Trac.api
        retryable(:tries => 5) do 
          self.new trac[:trac].tickets.get(id), project_id
        end
      end

      def self.create(*options)
        mandatory = options.shift
        attributes = {}
        attributes ||= options.shift
        trac = TicketMaster::Provider::Trac.api
        begin
          self.find_by_id trac[:trac].tickets.create(mandatory[:summary], mandatory[:description], attributes)
        rescue
          self
        end
      end

      def comments(*options)
        Comment.find(self.project_id, self.id, options)
      end

      def comment(*options)
        if options.empty?
          TicketMaster::Provider::Trac::Comment.new
        elsif options.first.is_a? Fixnum
          Comment.find_by_id(self.project_id, self.id, options.first)  
        elsif options.first.is_a? Hash
          Comment.find_by_attributes(self.project_id, self.id, options.first).first
        end
      end

      def comment!
        warn "Trac doesn't support creation of comments"
        [] 
      end

      private
      def normalize_datetime(datetime)
        Time.mktime(datetime.year, datetime.month, datetime.day, datetime.hour, datetime.min, datetime.sec)
      end

      # Extracted this code from facet http://api.mackframework.com/mack-facets/classes/Kernel.html
      def self.retryable(options = {}, &block)
        opts = { :tries => 1, :on => Exception }.merge(options)

        retry_exception, retries = opts[:on], opts[:tries]

        begin
          return yield
        rescue retry_exception
          retry if (retries -= 1) > 0
        end
        yield
      end
    end
  end
end
