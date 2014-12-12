require 'thread_safe'
require 'logger'

module Kaiwa
	class Launcher			
		#attr_accessor :launcher
		#attr_reader :launcher_supervisor

		include Kaiwa::SupervisorHelper	
		trap_exit :manager_crash_reporter		

		def initialize(options =  {}) 
			Kaiwa::Configuration.options = options						
		end

		def run					
			load_celluloid									 
			@manager = Kaiwa::Manager.new_with_link_and_supervision(self, 'manager')															
			Kaiwa::Cache.put('manager', @manager)			
		end

		def load_celluloid
			require 'celluloid'			
			require_relative './user.rb'
			require_relative './manager.rb'
			require_relative './message.rb'
		end	

		def manager_crash_reporter(actor, reason)
			Kaiwa::Logger.error("[Manager Crash Reporter] Actor crashed #{actor.inspect} because of #{reason.class}")
		end	

		def self.initialize_kaiwa_logger
			logger = ::Logger.new(STDOUT)

			unless Kaiwa::Logger.logger?
				logger.debug "Initializing Kaiwa logger..."
				Kaiwa::Logger.initialize_logger
				Kaiwa::Logger.info("Logger initialized.")
			end			
		end

		def self.initialize_kaiwa_cache
			Kaiwa::Cache.init
		end

		def self.run(options = {})						

			# The Cache is needed to store the launcher and launcher supervisors
			# so Kaiwa Cache is initialized upfront
			initialize_kaiwa_logger	
			initialize_kaiwa_cache									

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
			
			# Launcher acts as the primary supervisor to the entire stack. 
			launcher_supervisor = Launcher.supervise(options)
			launcher = launcher_supervisor.actors.last
			Kaiwa::Cache.put("launcher_supervisor", launcher_supervisor)
			Kaiwa::Cache.put("launcher", launcher)
			launcher.run				

			# while readable_io = IO.select([self_read])
   #        		signal = readable_io.first[0].gets.strip 
   #        		Kaiwa::Logger.debug("Received signal: #{signal}")         		
   #      	end
		end
	end	
end