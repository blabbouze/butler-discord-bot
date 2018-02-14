# Used for reading maymay config file and returning corresponding maymay objects
module DisrespectService
    extend self

    FILE_NAME = 'disrespect.txt'

    def generate_punchline
      File.open(FILE_NAME, 'r').readlines.sample.strip
    end

    def add_punchline(text)
      File.open(FILE_NAME, 'a+') { |f| f.puts text }
    end

    def add_and_generate(text)
      add_punchline(text)
      generate_punchline
    end
end