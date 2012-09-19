require 'simple-git-pair/command/base'
require 'simple-git-pair/helper'

module SimpleGitPair
  module Command
    class Add < Base
      def run!
        exit 1 unless ensure_pairs_file_exists
        initials, fullname = validate_opts
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
        puts message
      end

      private

      def validate_opts
        initials = opts.shift
        fullname = opts.join " "
        raise "Initials should contain no spaces" if /\s/.match opts.first
        raise "Please provide a Full Name" unless opts[1]
        [ initials, fullname ]
      end
    end
  end
end
