module TicketMaster::Provider
  module Trac 
    # Project class for ticketmaster-yoursystem
    # 
    # 
    class Project < TicketMaster::Provider::Base::Project
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
        trac = TicketMaster::Provider::Trac.api
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
          trac = TicketMaster::Provider::Trac.api
          if options.is_a? Hash
            TicketMaster::Provider::Trac::Ticket.find_by_id(trac[:trac].tickets.query(options).first, self[:name])
          end
        else
          TicketMaster::Provider::Trac::Ticket
        end
      end

      def ticket!(*options)
        options = options.first
        TicketMaster::Provider::Trac::Ticket.create options
      end

      def tickets(*options)
        mode = options.first
        trac = TicketMaster::Provider::Trac.api
        if options.empty?
          collect_tickets(trac[:trac].tickets.list)
        elsif mode.is_a? Array
          collect_tickets(mode)
        elsif mode.is_a? Hash
          collect_tickets(trac[:trac].tickets.query(mode))
        end
      end

      private
      def collect_tickets(tickets)
        tickets.collect do |ticket_id| 
          TicketMaster::Provider::Trac::Ticket.find_by_id(ticket_id, self[:name]) 
        end
      end

    end
  end
end
