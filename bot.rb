require 'discordrb'
require 'yaml'

require_relative 'model/maymay.rb'


# Configuration
creds = YAML.load_file('config/creds.yml')
maymays_config = YAML.load_file('config/maymay.yml')

# Minimum time (second) the bot have to wait before rebooting automatically
TIME_REBOOT = 300

# Data
maymays = {}

begin
  # Safety, don't restart too often
  uptime = Time.now

  ############
  # Init bot #
  ############

  bot = Discordrb::Commands::CommandBot.new token: creds['token'],
                                            client_id: creds['clientID'],
                                            prefix: '/'


  #######################
  # Init maymay cmmands #
  #######################
  maymays_config.each_pair do |command_name, command_args|
    # Identify command with symbols
    id_command = command_name.to_sym
    # Create model from configuration file
    maymays[id_command] = Maymay.new(command_args)

    # Create discord command
    bot.command id_command do |event, *args|
      # Remove command invocation
      event.message.delete

      # split args and text
      args, text = args.partition { |arg| arg.start_with?('-') }

      puts "args : #{args}"
      puts "text : #{text}"

      # Generate requested maymay
      generated_maymay = maymays[event.command.name].generate(text.join(' '), args)

      # Send it to the current text chanel
      event << "#{event.author.username} :"
      event.attach_file(File.open(generated_maymay,'r'))
    end

  end

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