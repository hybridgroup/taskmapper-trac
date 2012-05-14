module TaskMapper::Provider
  module Trac 
    # Project class for taskmapper-yoursystem
    # 
    # 
    class Project < TaskMapper::Provider::Base::Project
      # declare needed overloaded methods here
      
      attr_reader :created_at, :updated_at
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:repository => object.url,
                    :owner => object.username,
                    :name => object.name,
                    :id => object.name}
          else
            hash = object
          end
          super hash
        end
      end
      
      # copy from this.copy(that) copies that into this
      def copy(project)
        project.tickets.each do |ticket|
          copy_ticket = self.ticket!(:title => ticket.title, :description => ticket.description)
          ticket.comments.each do |comment|
            copy_ticket.comment!(:body => comment.body)
            sleep 1
          end
        end
      end

      def self.find(*options)
        mode = options.first
        trac = TaskMapper::Provider::Trac.api
        if mode.is_a? String
          self.new({:url => trac[:url], :username => trac[:username], :name=> "#{trac[:username]}-project"})
        end
      end

      def id
        1
      end

      def ticket(*options)
        unless options.empty?
          options = options.first
          trac = TaskMapper::Provider::Trac.api
          if options.is_a? Hash
            Ticket.find_by_id(trac[:trac].tickets.query(options).first, self[:name])
          end
        else
          TaskMapper::Provider::Trac::Ticket
        end
      end

      def ticket!(*options)
        options = options.first
        Ticket.create options
      end

      def tickets(*options)
        Ticket.find(self.name, options)
      end

    end
  end
end
