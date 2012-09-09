require 'simple-git-pair/command/change'

describe SimpleGitPair::Command::Change do
  before { Object.stub(:system) }
  let(:opts) { [] }
  let(:command) { described_class.new opts }

  describe "#run!" do
    subject { command.run! }

    context "there is NO pairs file" do
      let(:opts) { ["some_initials"] }

      before { command.stub(:ensure_pairs_file_exists).and_return false }
      it "complains and exit" do
        expect { subject }.to raise_error SystemExit
      end
    end

    context "there is a pairs file" do
      context "and multiple initials are passed in" do
        before {
          SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true
          SimpleGitPair::Helper.stub(:names_for).and_return ["Super Mario", "Pac Man"]
          command.stub! :system
        }
        let(:opts) { ['sm', 'pm'] }
        it "changes only username to pair name" do
          command.should_receive(:system).with("git config user.name 'Super Mario & Pac Man'")
          subject
        end
      end

      context "and single initial is passed in" do
        before {
          SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true
          SimpleGitPair::Helper.stub(:names_for).and_return ["Pac Man"]
          command.stub! :system
        }
        let(:opts) { ['pm'] }
        it "changes only username to single name" do
          command.should_receive(:system).with("git config user.name 'Pac Man'")
          subject
        end
      end

      context "and passed initial is unknown" do
        let(:opts) { ['unknown_dude'] }
        let(:ex)   { SimpleGitPair::Helper::NotFoundException.new "I don't know about #{opts.first}" }
        before {
          SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true
          SimpleGitPair::Helper.stub(:names_for).and_raise ex
          command.stub! :system
          command.should_receive(:puts).with(ex.message)
        }
        it { expect { subject }.to raise_error SystemExit }
      end
    end
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
