require 'spec_helper'
require 'simple-git-pair/command/change'

describe SimpleGitPair::Command::Change do
  before { Object.stub(:system) }
  let(:opts) { [] }
  let(:command) { described_class.new opts }

  describe "#run!" do
    subject { command.run! }

    it_should_behave_like "command that ensures that pairs file exists"

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
end
