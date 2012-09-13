require 'simple-git-pair/helper'

module SimpleGitPair
  module Command
    class Base
      attr_accessor :opts

      def initialize(opts = {})
        self.opts = opts
      end

      def run!(args = [])
        raise "Could you implement run! method on #{self.class}?"
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
