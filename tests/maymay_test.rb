require 'test/unit'
require_relative '../model/maymay.rb'
require_relative '../service/maymayService.rb'

class MaymayTest < Test::Unit::TestCase

  def setup
    @maymays = MaymayService.load('tests/maymayTest.yml')
  end

  def test_generate
    @maymays['victime'].generate("Kikoo")
  end
end