require 'simple-git-pair/command/base'

module SimpleGitPair
  module Command
    class List < Base
      USAGE = "#{BINARY_NAME} list"

      def run!
        exit 1 unless ensure_pairs_file_exists

        pairs = Helper.read_pairs
        if pairs.empty?
          puts "No pairs available. Use 'git pair add' to add more pairs."
        else
          pairs.each {|initials, fullname| puts "#{initials}: #{fullname}"}
        end
      end
    end
  end
end
