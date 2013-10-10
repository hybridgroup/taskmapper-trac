require 'active_support'
require 'openssl'
require 'trac4r'
require 'nokogiri'
require 'open-uri'

# FIXME: Hack for SSL problem
OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

require 'trac/trac'

require 'provider/trac'
require 'provider/ticket'
require 'provider/project'
require 'provider/comment'
require 'provider/version'
