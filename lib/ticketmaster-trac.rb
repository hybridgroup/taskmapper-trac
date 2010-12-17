require 'trac4r'

%w{ trac ticket project comment }.each do |f|
  require File.dirname(__FILE__) + '/provider/' + f + '.rb';
end

