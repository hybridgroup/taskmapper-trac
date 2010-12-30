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
    end

    # declare needed overloaded methods here
    def projects(*options)
       [Project.new({:url => @authentication.url, :username => @authentication.username})]  
    end

    def project(*options)
      unless options.empty?
        Project.new({:url => @authentication.url, :username => @authentication.username, :name => project_name})
      else
        TicketMaster::Provider::Trac::Project
      end
    end

    private
    def project_name
      @authentication.url.split(/\//)[-1]
    end

  end
end
