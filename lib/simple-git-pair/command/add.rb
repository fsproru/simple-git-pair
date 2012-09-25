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
        existing_user = pairs[initials]
        message = ""

        if existing_user
          exit 1 unless user_needs_update? existing_user, initials, fullname
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

      def user_needs_update? existing_user, initials, fullname
        if existing_user == fullname
          puts "#{fullname} already exists"
          false
        elsif not agree("#{initials} has already taken by #{existing_user}. Override it with #{fullname}? (yes/no)")
          puts "#{fullname} was not added"
          false
        else
          true
        end
      end
    end
  end
end
