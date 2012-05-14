module TaskMapper::Provider
  # This is the Yoursystem Provider for taskmapper
  module Trac
    include TaskMapper::Provider::Base
    
    # This is for cases when you want to instantiate using TaskMapper::Provider::Yoursystem.new(auth)
    def self.new(auth = {})
      TaskMapper.new(:trac, auth)
    end

    def authorize(auth = {})
      @authentication ||= TaskMapper::Authenticator.new(auth)
      auth = @authentication
      @trac = ::Trac.new(auth.url, auth.username, auth.password)
      TaskMapper::Provider::Trac.api = {:trac => @trac, :url => auth.url, :username => auth.username, :password => auth.password}
    end

    # declare needed overloaded methods here
    def projects(*options)
       [Project.new({:url => @authentication.url, :username => @authentication.username, :name => "#{@authentication.username}-project"})]  
    end

    def project(*options)
      unless options.empty?
        Project.new({:url => @authentication.url, :username => @authentication.username, :name => "#{@authentication.username}-project"})
      else
        TaskMapper::Provider::Trac::Project
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
