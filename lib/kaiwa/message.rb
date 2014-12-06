module Kaiwa
	class Message
		attr_accessor :from, :to, :content
		
		def initialize(from, to, content)
			@from = from
			@to = to
			@content = content
		end

		def process_message
			Kaiwa::Logger.debug("#{self.from}: #{self.content} - _#{self.to}_")
		end
	end
end
