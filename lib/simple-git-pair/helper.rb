require 'yaml' # need to explicitly require yaml for ruby 1.8.7
require 'simple-git-pair/version'

module SimpleGitPair
  module Helper

    class NotFoundException < Exception; end

    class << self
      PAIRS_FILE_NAME = '.git_pairs'
      PAIRS_FILE_PATH = File.expand_path("~/#{PAIRS_FILE_NAME}")

      def show_help
        puts <<-EOS

          #{SUMMARY}
          Usage: git-pair <initial1> <initial2>

          Commands:
            init - creates sample #{PAIRS_FILE_NAME} config
        EOS
      end

      def complain_about_pairs_file
        puts <<-EOS

          Please create #{PAIRS_FILE_NAME} file in your home directory in yaml format:
            ae: Alfred Einstein
            nt: Nikola Tesla
        EOS
      end

      def say_pairs_file_exists
        puts <<-EOS
          #{PAIRS_FILE_PATH} already exists. You're good to go.
        EOS
      end

      def names_for args
        pairs = YAML.load_file PAIRS_FILE_PATH

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
    end
  end
end
