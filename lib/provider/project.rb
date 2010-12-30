module TicketMaster::Provider
  module Trac 
    # Project class for ticketmaster-yoursystem
    # 
    # 
    class Project < TicketMaster::Provider::Base::Project
      # declare needed overloaded methods here
      API = TracAPI
      
      def initialize(*object)
        if object.first
          object = object.first
          @system_data = {:client => object}
          unless object.is_a? Hash
            hash = {:repository => object.url,
                    :user => object.username}
            
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
        if mode.is_a? String
          self.new({:url => API.url, :username => "#{API.username}-project"})
        end
      end

      def ticket(*options)
        unless options.empty?
          options = options.first
          if options.is_a? Hash
            TicketMaster::Provider::Trac::Ticket.find_by_id API.api.tickets.query(options).first
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
        if options.empty?
          collect_tickets(API.api.tickets.list)
        elsif mode.is_a? Array
          collect_tickets(mode)
        elsif mode.is_a? Hash
          collect_tickets(API.api.tickets.query(mode))
        end
      end

      private
      def collect_tickets(tickets)
        tickets.collect { |ticket_id| TicketMaster::Provider::Trac::Ticket.find_by_id ticket_id}
      end

    end
  end
end
