module Kaiwa
	module Cache
		def self.put(key, value)
			_key = "kaiwa:#{key.to_json}"
			_value = value			
			cache[key] = value			
		end

		def self.get(key)
			_key = "kaiwa:#{key.to_json}"
			cache[key]
		end

		def self.initialize_cache
			@cache ||= {}
		end

		def self.cache
			@cache
		end

		def self.init
			initialize_cache
			cache
		end
	end
end