module SimpleGitPair
  module Command
    class Base
      attr_accessor :opts

      def initialize(opts = {})
        self.opts = opts
      end

      def run!
        raise "Could you implement run! method on #{self.class}?"
      end
    end
  end
end
