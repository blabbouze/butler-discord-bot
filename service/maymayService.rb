require 'yaml'

# Used for reading maymay config file and returning corresponding maymay objects
module MaymayService
  extend self

  #
  # Read maymay config file and returns a Hash of Maymay
  #
  # @param config_file_path [string] maymay config path
  #
  # @return [Hash<string,Maymay>] Hash that contains the Maymay loaded associated with their names
  def load(config_file_path)
    maymays = {}
    maymays_config = YAML.load_file(config_file_path)

    maymays_config.each_pair do |command_name, command_args|
      maymays[command_name] = Maymay.new(command_args)
    end

    return maymays
  end
end