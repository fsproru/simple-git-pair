require 'simple-git-pair/command/base'

module SimpleGitPair
  module Command
    class Change < Base
      def run!
        exit 1 unless ensure_pairs_file_exists

        begin
          system "git config user.name '#{(Helper.names_for opts).join ' & '}'"
        rescue Helper::NotFoundException => ex
          puts ex.message
          exit 1
        end

        system "git config user.name" # output current username
      end

      private
    end
  end
end
