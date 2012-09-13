require 'simple-git-pair/command/base'

describe SimpleGitPair::Command::Base do
  let(:command) { described_class.new [] }

  describe "#run!" do
    subject { command.run! }
    it { expect { subject }.to raise_error RuntimeError }
  end

  describe "#ensure_pairs_file_exists" do
    subject { command.send :ensure_pairs_file_exists }

    context "there is NO pairs file" do
      before { SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return false }

      context "and user agrees to create it" do
        before { command.stub(:agree).and_return true }
        it "creates a pairs file and returns true" do
          SimpleGitPair::Helper.should_receive(:create_pairs_file).and_return true
          subject.should be_true
        end
      end

      context "and user disagrees to create it" do
        before { command.stub(:agree).and_return false }
        it "complains and return false" do
          SimpleGitPair::Helper.should_receive :complain_about_pairs_file
          subject.should be_false
        end
      end
    end
  end
end
