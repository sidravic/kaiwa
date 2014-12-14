module Kaiwa
  module ManagerUserOps
    extend ActiveSupport::Concern
    module ClassMethods
      def create_user(handle)
        manager.get_user(handle)
      end

      def delete_user(handle)
        # get user from handle
        # user  = get_user_from_data_store
        manager.delete_user(handle)
      end

      def manager
        @manager = Kaiwa::Manager.manager
      end
    end

    included do
      self.extend(ClassMethods)

      def get_user(handle)
        raise "Invalid handle" if handle.nil? or handle.strip == ''
        user_actor = Celluloid::Actor[handle.to_sym]

        if user_actor
          #Kaiwa::Manager.manager.link(user_actor)
          user_actor
        else
          create_user(handle)
        end
      end

      def create_user(handle)
        Kaiwa::User.new_with_link_and_supervision(Kaiwa::Manager.manager, handle, handle)
      end

      def delete_user(handle)
        Kaiwa::User.unlink_and_terminate_actor(Kaiwa::Manager.manager, handle)
      end
    end
  end
end