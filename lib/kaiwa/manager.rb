module Kaiwa
	class Manager		
		include Kaiwa::SupervisorHelper
		trap_exit :manager_error_notifier

		include Kaiwa::ManagerUserOps
		include Kaiwa::ManagerMessageOps

		# def get_user(handle)
		# 	raise "Invalid handle" if handle.blank? or handle.nil?
		# 	user_actor = Celluloid::Actor[handle.to_sym].nil?
		# 	create_user(handle) if user_actor.nil?
		# 	user_actor
		# end
    #
		# def create_user(handle)
		# 	Kaiwa::User.new_with_link_and_supervision(self, handle, handle)
		# end
    #
		# def delete_user()
		# 	Kaiwa::User.unlink_and_terminate_actor(self, user)
		# end

		def self.manager
			Kaiwa::Logger.debug "Manager exists" if !Celluloid::Actor['manager'].nil?
			create_manager if Celluloid::Actor['manager'].nil?
			Celluloid::Actor['manager']
		end

		def self.create_manager
			launcher = Celluloid::Actor['launcher']
			new_with_link_and_supervision(launcher, 'manager')
		end

		def manager_error_notifier(actor, reason)
			Kaiwa::Logger.debug("-" * 20)
			Kaiwa::Logger.debug("Crash Report:- #{actor.inspect} crashed: #{reason.class}")
		end
	end
end