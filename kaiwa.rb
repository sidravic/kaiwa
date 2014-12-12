require 'rubygems'
require 'bundler'

Bundler.setup(:default)
require 'spoon'
require 'celluloid'
require 'json'
require 'active_support'
require 'lib/kaiwa/configuration.rb'
require 'lib/kaiwa/logger.rb'
require 'lib/kaiwa/cache.rb'
require 'lib/kaiwa/redis_connection'
require 'lib/kaiwa/supervisor_helper.rb'
require 'lib/kaiwa/launcher.rb'
require 'pry'



logger = Logger.new(STDOUT)
logger.debug(STDOUT)
logger.debug(Kaiwa::Logger.logger?)

#Kaiwa::Launcher.run

# unless Kaiwa::Logger.logger?
#     logger.debug "Initializing Kaiwa logger..."
#     Kaiwa::Logger.initialize_logger
#     logger.debug "Logger initialized."    
# end

# self_read, self_write = IO.pipe

# %w(INT TERM USR1 USR2 TTIN).each do |sig|
#     begin
#         trap sig do
#             self_write.puts(sig)
#         end   
#     rescue ArgumentError
#         puts "Signal #{sig} not supported"
#     end
# end

# logger.debug("Blocking on IO now")
# Thread.new do 
#     loop do 
#         sleep(rand(10))
#         logger.debug('From the loop');
#     end
# end



