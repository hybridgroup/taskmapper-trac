module TicketMaster::Provider
  # This is the Yoursystem Provider for ticketmaster
  module TracProvider
    include TicketMaster::Provider::Base
    
    # This is for cases when you want to instantiate using TicketMaster::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TicketMaster.new(:trac, auth)
    end

    def authorize(auth = {})
      @authentication ||= TicketMaster::Authenticator.new(auth)
      auth = @authentication
      @trac = Trac.new(auth.url, auth.username, auth.password)
    end

    # declare needed overloaded methods here
    def projects(*options)
      []
    end

  end
end
