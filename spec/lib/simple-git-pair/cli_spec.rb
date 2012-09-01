require 'simple-git-pair/cli'

describe SimpleGitPair::Cli do
  before { Object.stub(:system) }
  let(:opts) { [] }
  let(:cli) { described_class.new opts }

  describe "#run!" do
    subject { cli.run! }

    context "there is no option passed in" do
      let(:opts) { [] }
      it "shows help" do
        SimpleGitPair::Helper.should_receive :show_help
        expect { subject }.to raise_error SystemExit
      end
    end

    context "with --help or -h option" do
      let(:opts) { ['--help', '-h'] }
      it "shows help" do
        SimpleGitPair::Helper.should_receive :show_help
        expect { subject }.to raise_error SystemExit
      end
    end

    context "there is NO pairs file" do
      before { SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return false }
      let(:opts) { ["some_initials"] }
      it "complains and exit" do
        SimpleGitPair::Helper.should_receive :complain_about_pairs_file
        expect { subject }.to raise_error SystemExit
      end
    end

    context "there is a pairs file" do
      context "and multiple initials are passed in" do
        before {
          SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true
          SimpleGitPair::Helper.stub(:names_for).and_return ["Super Mario", "Pac Man"]
          cli.stub! :system
        }
        let(:opts) { ['sm', 'pm'] }
        it "changes only username to pair name" do
          cli.should_receive(:system).with("git config user.name 'Super Mario & Pac Man'")
          subject
        end
      end

      context "and single initial is passed in" do
        before {
          SimpleGitPair::Helper.stub(:pairs_file_exists?).and_return true
          SimpleGitPair::Helper.stub(:names_for).and_return ["Pac Man"]
          cli.stub! :system
        }
        let(:opts) { ['pm'] }
        it "changes only username to single name" do
          cli.should_receive(:system).with("git config user.name 'Pac Man'")
          subject
        end
      end
    end
  end
end
