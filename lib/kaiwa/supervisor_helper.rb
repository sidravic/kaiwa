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
				self.supervise_as(supervision_name.to_sym, *args)
				new_object_actor = Celluloid::Actor[supervision_name.to_sym]
				monitor.link(new_object_actor)
				Kaiwa::Logger.info("New supervised actor created of type #{self.to_s} linking to #{monitor.to_s}")
				new_object_actor
			end

			def unlink_and_terminate_actor(monitor, object)
				monitor.unlink(object)
				object.terminate
			end
		end

		included do 
			include Celluloid
			self.extend(ClassMethods)
		end
	end
end