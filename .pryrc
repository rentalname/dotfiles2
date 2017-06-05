begin
  require 'awesome_print'
rescue LoadError
else
  AwesomePrint.pry!
end

if Module.const_defined?(:Celluloid)
  Celluloid.shutdown_timeout = 1
end
