require 'simple-git-pair/command/base'
require 'simple-git-pair/helper'

module SimpleGitPair
  module Command
    class Change < Base
      def run!
        unless Helper.pairs_file_exists?
          Helper.complain_about_pairs_file
          exit 1
        end

        begin
          system "git config user.name '#{(Helper.names_for ARGV).join ' & '}'"
        rescue Helper::NotFoundException => ex
          puts ex.message
          exit 1
        end

        system "git config user.name" # output current username
      end
    end
  end
end
