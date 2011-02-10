require 'ticketmaster'
require 'trac4r'
require 'nokogiri'
require 'open-uri'

require 'lib/trac/trac'

%w{ trac ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

