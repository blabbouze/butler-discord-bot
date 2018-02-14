require 'test/unit'
require 'fileutils'

require_relative '../model/maymay.rb'
require_relative '../service/maymayService.rb'

require_relative '../service/disrespectService.rb'
require_relative '../handles/assetHandles.rb'


class MaymayTest < Test::Unit::TestCase

  def setup
    @maymays = MaymayService.load('config/maymay.yml')

    @out_folder = Maymay::MAYMAY_OUT_FOLDER

    # Create and clear folder if needed
    Dir.mkdir(@out_folder) unless File.exists?(@out_folder)
    FileUtils.rm_rf("#{@out_folder}/.", secure: true)
  end

  def test_generateDisrespect
    puts "lol"
    puts HANDLES::ASSET::randomize('lol','mdr')
  end

  def test_generate
    @maymays.each_value do |maymay|
      assert(!File.exists?("#{@out_folder}/#{maymay.asset}"))
      maymay.generate("test")
      assert(File.exists?("#{@out_folder}/#{maymay.asset}"))
    end 
  end



end