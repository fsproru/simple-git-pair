require 'yaml' # need to explicitly require yaml for ruby 1.8.7
require 'simple-git-pair/version'

module SimpleGitPair
  module Helper

    class NotFoundException < Exception; end

    class << self
      PAIRS_FILE_NAME = '.git_pairs'
      PAIRS_FILE_PATH = File.join ENV['HOME'], PAIRS_FILE_NAME

      def complain_about_pairs_file
        puts <<-EOS
Couldn't find #{PAIRS_FILE_PATH}
Please run: git pair init
        EOS
      end

      def say_pairs_file_exists
        puts Rainbow("#{PAIRS_FILE_PATH} already exists. You're good to go.").green
      end

      def names_for args
        pairs = read_pairs

        names = []
        args.each do |opt|
          raise NotFoundException.new "There is no entry for #{opt} in #{PAIRS_FILE_PATH}" unless pairs[opt]
          names << pairs[opt]
        end

        names
      end

      def pairs_file_exists?
        File.exist? PAIRS_FILE_PATH
      end

      def create_pairs_file
        File.open(PAIRS_FILE_PATH, "w") { |f| f.write "nt: Nikola Tesla\nae: Alfred Einstein" }
      end

      def save_pairs hash
        File.open(PAIRS_FILE_PATH, 'w' ) do |file|
          YAML.dump( hash, file )
        end
      end

      def read_pairs
        YAML.load_file PAIRS_FILE_PATH
      end
    end
  end
end
