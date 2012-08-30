require 'yaml'

module SimpleGitPair
  module Helper
    class << self
      PAIRS_FILE = File.expand_path('~/.pairs')

      def show_help
        puts <<-EOS

          Changes your git user.name to specified names from #{PAIRS_FILE}
          Usage: git-pair <initial1> <initial2>
        EOS
      end

      def complain_about_pairs_file
        puts <<-EOS

          Please create .pairs file in your home directory in yaml format:
            ae: Alfred Einstein
            nt: Nikola Tesla
        EOS
      end

      def names_for args
        pairs = YAML.load_file PAIRS_FILE

        names = []
        args.each do |opt|
          raise "There is no entry for #{opt} in #{PAIRS_FILE}" unless pairs[opt]
          names << pairs[opt]
        end

        names
      end

      def check_for_pairs_file
        unless File.exist? PAIRS_FILE
          complain_about_pairs_file and exit 0
          exit 1
        end
      end
    end
  end
end
