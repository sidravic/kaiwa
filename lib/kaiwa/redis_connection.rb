require 'connection_pool'
require 'redis'
require 'uri'

module Kaiwa
	class RedisConnection
		POOL_SIZE = 3
		POOL_TIMEOUT = 3

		def self.create(options = {})			
			ConnectionPool.new(:timeout => POOL_TIMEOUT, :size => POOL_SIZE) do 
				build_client(options)	
			end
		end

		private

		def self.build_client(options)
			client = Redis.new(client_options(options))
		end

		def self.client_options(options = {})
			default_options.merge(options)
		end

		def self.default_options
			{
				:host => 'localhost',
				:port => 6379
			}
		end
	end
end