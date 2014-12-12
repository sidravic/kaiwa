module Kaiwa
	module SupervisorHelper		
		extend ::ActiveSupport::Concern

		module ClassMethods
			def new_with_link(monitor, *args)
				new_object = self.new(*args)
				monitor.link(new_object)
				Kaiwa::Logger.info("New actor created of type #{self.to_s} linking to #{monitor.to_s}")
				new_object
			end

			def new_with_link_and_supervision(monitor, supervision_name, *args)
				new_object = self.supervise_as(supervision_name.to_sym, *args)
				monitor.link(new_object)
				Kaiwa::Logger.info("New supervised actor created of type #{self.to_s} linking to #{monitor.to_s}")
				::Celluloid::Actor[supervision_name.to_sym]
			end

			def unlink_and_terminate_actor(monitor, object)
				monitor.unlink(object)
				object.terminate
			end
		end

		included do 
			include Celluloid
			self.extend(ClassMethods)

			trap_exit :global_crash_notifier

			def global_crash_notifier(actor, reason)
				Kaiwa::Logger.error("#{actor.inspect} crashed: #{reason.class}")
			end
		end
	end
end