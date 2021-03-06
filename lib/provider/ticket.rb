module TaskMapper::Provider
  module Trac
    # Ticket class for taskmapper-yoursystem
    #

    class Ticket < TaskMapper::Provider::Base::Ticket
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
        normalize_datetime(self[:created_at])
      end

      def updated_at
        normalize_datetime(self[:updated_at])
      end

      def self.find_by_id(id, project_id)
        tries ||= 3
        self.new trac[:trac].tickets.get(id), project_id
      rescue ::Trac::TracException
        retry unless (tries-=1).zero?
      end

      def self.find(project_id, *options)
        mode = options[0].first
        if options[0].empty?
          self.find_all(project_id, trac[:trac].tickets.list)
        elsif mode.is_a? Array
          self.find_all(project_id, mode)
        elsif mode.is_a? Hash
          self.find_all(project_id, trac[:trac].tickets.query(mode))
        end
      end

      def self.find_all(project_id, tickets)
        tickets.collect do |ticket_id|
          self.find_by_id(ticket_id, project_id)
        end
      end

      def self.create(*options)
        mandatory = options.shift
        attributes = {}
        attributes ||= options.shift
        self.find_by_id trac[:trac].tickets.create(mandatory[:summary], mandatory[:description], attributes)
      rescue
        self
      end

      def self.trac
        TaskMapper::Provider::Trac.api
      end

      def comments(*options)
        Comment.find(self.project_id, self.id, options)
      end

      def comment(*options)
        if options.empty?
          TaskMapper::Provider::Trac::Comment.new
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
        datetime = datetime.to_time
      end

    end
  end
end
