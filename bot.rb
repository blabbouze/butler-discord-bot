require 'discordrb'
require 'yaml'


config = YAML.load_file('config/creds.yml')



# Minimum time (second) the bot have to wait before rebooting automatically
TIME_REBOOT = 300

begin
  # Safety, don't restart too often
  uptime = Time.now


  ############
  # Init bot #
  ############

  puts config['token']
  puts config['clientID']

  bot = Discordrb::Commands::CommandBot.new token: config['token'],
                                            client_id: config['clientID'],
                                            prefix: '/'




  # Start the bot (must be done at the end)
  bot.run

rescue
  # If exception we stop the bot
  bot.stop
ensure
  uptime = Time.now - uptime

  if uptime < TIME_REBOOT
    sleep(TIME_REBOOT-uptime)
  end

  # And restart it
  exec("ruby bot.rb")
end