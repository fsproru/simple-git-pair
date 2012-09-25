require 'simple-git-pair/command/base'
require 'rainbow'

module SimpleGitPair
  module Command
    class Delete < Base
      USAGE = "#{BINARY_NAME} delete <initials>"

      def run!
        exit 1 unless ensure_pairs_file_exists

        initials, valid_opts, errors = validate_opts
        unless valid_opts
          puts errors.join "\n"
          puts "Usage: #{USAGE}"
          exit 1
        end

        pairs = Helper.read_pairs
        existent_user = pairs[initials]

        if existent_user
          pairs.delete initials
          Helper.save_pairs pairs
          puts "Deleted #{initials}: #{existent_user}".color(:green)
        else
          puts "There is no #{initials}"
        end
      end

      private

      ##
      # Validate and return options
      #
      # Returns: array
      #   [initials, status, errors]
      def validate_opts
        initials = opts.shift
        errors = []
        errors << "Initials should contain no spaces" if /\s/.match initials
        [ initials, errors.empty?, errors ]
      end
    end
  end
end
