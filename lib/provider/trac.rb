module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module Trac
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:trac, auth)
    end

    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      @trac = ::Trac.new(auth.url, auth.username, auth.password)
      TicketMaster::Provider::Trac.api = {:trac => @trac, :url => auth.url, :username => auth.username, :password => auth.password}
    end

    # declare needed overloaded methods here
    def projects(*options)
       [Project.new({:url => @authentication.url, :username => @authentication.username, :name => "#{@authentication.username}-project"})]  
    end

    def project(*options)
      unless options.empty?
        Project.new({:url => @authentication.url, :username => @authentication.username, :name => "#{@authentication.username}-project"})
      else
        TicketMaster::Provider::Trac::Project
      end
    end

    def self.api=(trac_instance)
      @api = trac_instance
    end

    def self.api
      @api
    end

    def valid?
      begin
        @trac.tickets.list
        true
      rescue Exception
        false
      end
    end

  end
end
