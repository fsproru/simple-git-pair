require 'simple-git-pair/helper'

module SimpleGitPair
  class Cli
    attr_accessor :opts

    def initialize(opts = {})
      self.opts = opts
    end

    def run!
      if opts.delete "--help" or opts.delete "-h" or opts.empty?
        Helper.show_help
        exit 0
      end

      if opts.delete "init"
        exit(init_cmd ? 0 : 1)
      end

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

    private

    def init_cmd
      if Helper.pairs_file_exists?
        Helper.say_pairs_file_exists
      else
        Helper.create_pairs_file
      end
    end
  end
end
