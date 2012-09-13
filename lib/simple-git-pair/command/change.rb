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

      # Interactively creates a sample pairs file if pairs file doesn't exist
      def ensure_pairs_file_exists
        file_exists = Helper.pairs_file_exists?

        unless file_exists
          if agree("Can't find a config file. Create a sample one? (yes/no)")
            file_exists = Helper.create_pairs_file
          else
            Helper.complain_about_pairs_file
            file_exists = false
          end
        end

        file_exists
      end
    end
  end
end
