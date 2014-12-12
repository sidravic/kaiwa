# KAIWA

Kaiwa is simple experiment to rebuild the functionalities offered by XMPP using JRUBY and Celluloid

## Basic Usage

Kaiwa is still an experiment and not suitable for any production use. It may as well have way too many bugs

To try it in IRB

    require 'kaiwa'
    Kaiwa::Launcher.run
    u1 = Kaiwa::Manager.create_user('supersid')
    u2 = Kaiwa::Manager.create_user('piyoo')
    u1.send_message("Hello world", u2)


    D, [2014-12-12T18:27:14.280000 #31322] DEBUG -- : supersid: Hello world - _piyoo_   


## How it works

Kaiwa launches actors for each users and accepts messages using the basic mailbox approach. It uses the `exclusive` or Erlang mode for each actor's `receive` loop. 

The goal is to persist messages sent onto redis.


