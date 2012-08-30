require 'spec_helper'
require 'simple-git-pair/helper'

describe SimpleGitPair::Helper do
  describe :names_for do
    it ""
  end

  describe :check_for_pairs_file do
    context "pairs file exists" do
      before { File.stub(:exist?).and_return true }
      it "does not complain" do
        described_class.should_not_receive :complain_about_pairs_file
        described_class.check_for_pairs_file
      end
    end

    context "there is no pairs file" do
      before { File.stub(:exist?).and_return false }
      it "complains and exits" do
        described_class.should_receive :complain_about_pairs_file
        described_class.should_receive :exit
        described_class.check_for_pairs_file
      end
    end
  end
end
