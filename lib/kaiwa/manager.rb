module Kaiwa
	class Manager		
		include Kaiwa::SupervisorHelper

		def create_user(handle)
			user = Kaiwa::User.new_with_link_and_supervision(self, handle, handle)
			#user.persist!
		end

		def delete_user()
			Kaiwa::User.unlink_and_terminate_actor(self, user)
		end

		def self.create_user(handle)
			manager = Kaiwa::Cache.get('manager')
			manager.create_user(handle)
		end

		def self.delete_user(handle)
			# get user from handle
			# user  = get_user_from_data_store
			manager.delete_user(user)
		end
	end
end