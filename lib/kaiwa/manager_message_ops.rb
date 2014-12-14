module Kaiwa
  module ManagerMessageOps
    extend ActiveSupport::Concern

    module ClassMethods
      def send_message(from, to, message_body, &block)
        from_actor = manager.get_user(from)
        to_actor = manager.get_user(to)

        raise "UserNotFound" if from_actor.nil?
        raise "UserNotFound" if to_actor.nil?

        from_actor.send_message(message_body, to_actor, &block)
      end
    end

    included do
      self.extend(ClassMethods)
    end
  end
end