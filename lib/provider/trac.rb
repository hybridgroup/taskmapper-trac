module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module Trac
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Yoursystem.new(auth)
    def self.new(url, auth = {})
      @url = url
      TicketMaster.new(:trac, auth)
    end

    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      if (auth.url.nil? and auth.username.nil?)
        raise "Please provide at least an url and username"
      end
    end

    # declare needed overloaded methods here

  end
end
