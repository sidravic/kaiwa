require 'thread_safe'
require 'logger'

module Kaiwa
	class Launcher

		def initialize(options =  {}) 
			Kaiwa::Configuration.options = options			
		end

		def run
			load_celluloid
			daemonize
			@manager = Kaiwa::Manager.new
			@active_connections = ThreadSafe::Array.new
		end

		def load_celluloid
			require 'celluloid'
			require_relative './user.rb'
			require_relative './manager.rb'
			require_relative './message.rb'
		end

		def daemonize
			if RUBY_PLATFORM == 'java'
				
			else
				::Process.daemon(true, true)
			end
		end

		def self.run(options = {})	
		
			logger = ::Logger.new(STDOUT)						

			unless Kaiwa::Logger.logger?
				logger.debug "Initializing Kaiwa logger..."
				Kaiwa::Logger.initialize_logger
				logger.debug "Logger initialized."    
			end

			self_read, self_write = IO.pipe

			%w(INT TERM USR1 USR2 TTIN).each do |sig|
				begin
					trap sig do
						self_write.puts(sig)
					end   
				rescue ArgumentError
					puts "Signal #{sig} not supported"
				end
			end

			@launcher = Launcher.new(options)
			@launcher.run						
		end
	end
end