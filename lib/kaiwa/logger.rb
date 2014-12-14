require 'logger'

module Kaiwa
	module Logger
		extend self 

		def initialize_logger(log_file = 'kaiwa.log')
			old_logger = defined?(@logger) ? @logger : nil
			@logger = ::Logger.new(log_file)
			@logger.level = ::Logger::DEBUG			

			if Kaiwa::Configuration.development?
				old_logger.close if old_logger and !Kaiwa::Configuration.testing?
			end	
				
			@logger
		end

		def logger?
			!@logger.nil?
		end

		def logger
			initialize_logger if !logger?
			@logger
		end

		def debug(msg)			
			@logger.debug msg
		end

		def info msg
			@logger.debug msg
		end

		def error msg
			@logger.debug msg
		end

		def warn msg
			@logger.debug msg
		end
	end
end