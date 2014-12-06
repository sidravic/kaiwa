module Kaiwa
	class User
		include Celluloid

		attr_accessor :handle, :roster, :presence

		exclusive :set_presence, :roster, :receive_message, :send_message

		def initialize(handle)
			@handle = handle	
			async.receive_messages		
		end

		def set_presence(status = :offline)
			@presence = status
		end

		def roster(roster)
			@roster = roster
		end

		def receive_messages
			loop do 
				receive do |message|
					if message.instance_of? Kaiwa::Message
						message.process_message
					else
						# ignore
					end
				end
			end
		end

		def send_message(message, to)			
			msg = Kaiwa::Message.new(self.handle, 
									 to.handle,
									 message
									)

			to.mailbox << msg
		end
	end
end