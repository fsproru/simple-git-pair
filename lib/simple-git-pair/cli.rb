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

      unless Helper.pairs_file_exists?
        Helper.complain_about_pairs_file
        exit 1
      end

      system "git config user.name '#{(Helper.names_for ARGV).join ' & '}'"
      system "git config user.name" # output current username
    end
  end
end
