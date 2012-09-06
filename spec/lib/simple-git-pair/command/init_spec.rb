require 'simple-git-pair/command/init'

describe SimpleGitPair::Command::Init do
  describe "#run!" do
    subject { described_class.new.run! }

    context "pairs file already exists" do
      before { SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true }
      it "complains and exit" do
        SimpleGitPair::Helper.should_receive :say_pairs_file_exists
        subject
      end
    end

    context "there is no pairs file" do
      before { SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return false }
      it "creates a pairs file" do
        SimpleGitPair::Helper.should_receive(:create_pairs_file).and_return true
        subject
      end
    end
  end
end
