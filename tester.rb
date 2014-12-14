require 'kaiwa'
Kaiwa::Launcher.run
Celluloid.logger = Kaiwa::Logger.logger

class KaiwaTest
  include Celluloid
  Celluloid::LINKING_TIMEOUT = 5

  def initialize
  end

  def create_kaiwa_users(handle)
     Kaiwa::Manager.create_user(handle)
  end

  def send_kaiwa_messages(to_handle, from_handle, message)
    Kaiwa::Manager.send_message(to_handle, from_handle, message)
  end
end

#kaiwa_test_pool = KaiwaTest.pool(size: 40)

 # (0..4).to_a.each do |index|
 #   kaiwa_test_pool.async.create_kaiwa_users("user_#{index}")
 #
 # end

#sleep(10)

# 100000.times do
#   user1 = "user_#{rand(100000)}"
#   user2 = "user_#{rand(100000)}"
#
#   #kaiwa_test_pool.async.send_kaiwa_messages(user1, user2, "Hello world #{rand(100)}")
# end



