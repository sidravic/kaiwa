module Kaiwa
	module Configuration
		# Expects
		# Kaiwa::Configuration.configure do 
		#   environment: development
		# end
		DEFAULT_OPTIONS = {
			environment: 'development'
		}

		def self.options=(opts)		
			@options = DEFAULT_OPTIONS.merge!(opts)
		end

		def self.options
			@options ||= DEFAULT_OPTIONS.dup
		end

		def self.environment
			options[:environment]
		end

		def self.development?			
			environment == 'development?'
		end

		class << self 
			alias_method :development_mode?, :development?
			alias_method :test?, :development?
			alias_method :test_mode?, :development?
		end
	end
end