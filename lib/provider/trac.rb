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
      @trac = Trac.new(@url, auth.login, auth.password)
    end

    # declare needed overloaded methods here

  end
end
