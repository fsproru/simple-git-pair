require 'simple-git-pair/command/base'
require 'simple-git-pair/helper'

module SimpleGitPair
  module Command
    class Init < Base
      def run!
        if Helper.pairs_file_exists?
          Helper.say_pairs_file_exists
        else
          Helper.create_pairs_file
        end
      end
    end
  end
end
