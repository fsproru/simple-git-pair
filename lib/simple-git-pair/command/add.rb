require 'simple-git-pair/command/base'
require 'rainbow'

module SimpleGitPair
  module Command
    class Add < Base
      USAGE = "#{BINARY_NAME} add <initials> <Full Name>"

      def run!
        exit 1 unless ensure_pairs_file_exists

        initials, fullname, valid_opts, errors = validate_opts
        unless valid_opts
          puts errors.join "\n"
          puts "Usage: #{USAGE}"
          exit 1
        end

        pairs = Helper.read_pairs
        existent_user = pairs[initials]
        message = ""

        if existent_user
          unless agree("#{initials} has alredy taken by #{existent_user}. Override it with #{fullname}? (yes/no)")
            puts "#{fullname} was not added"
            exit 1
          end

          message = "Updated #{initials} to be #{fullname}"
        else
          message = "Added #{fullname}"
        end

        pairs[initials] = fullname
        Helper.save_pairs pairs
        puts message.color(:green)
      end

      private

      ##
      # Validate and return options
      #
      # Returns: array
      #   [initials, fullname, status, errors]
      def validate_opts
        initials = opts.shift
        fullname = opts.join " "
        errors = []
        errors << "Initials should contain no spaces" if /\s/.match initials
        errors << "Please provide a Full Name" if fullname == ""
        [ initials, fullname, errors.empty?, errors ]
      end
    end
  end
end
