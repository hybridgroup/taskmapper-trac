require 'active_support'
require 'ticketmaster'
require 'openssl'
require 'trac4r'
require 'nokogiri'
require 'open-uri'

# FIXME: Hack for SSL problem 
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

require File.dirname(__FILE__) + '/trac/trac'

%w{ trac ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

