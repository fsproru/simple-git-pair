require 'spec_helper'
require 'simple-git-pair/command/delete'

describe SimpleGitPair::Command::Delete do
  let(:opts) { [] }
  let(:command) { described_class.new opts }

  describe "#run!" do
    subject { command.run! }
    before { command.stub :puts }

    it_should_behave_like "command that ensures that pairs file exists"

    context "there is a pairs file" do
      before { command.stub(:ensure_pairs_file_exists).and_return true }

      context "and specified pair exists" do
        let(:opts) { ["dm"] }
        before { SimpleGitPair::Helper.stub(:read_pairs).and_return({"dm" => "Delete me", "km" => "Keep Me"}) }

        it "deletes it" do
          SimpleGitPair::Helper.should_receive(:save_pairs).with({"km" => "Keep Me"})
          subject
        end
      end

      context "and specified pair does NOT exist" do
        let(:opts) { ["dm"] }
        before { SimpleGitPair::Helper.stub(:read_pairs).and_return({"km" => "Keep Me"}) }

        it "does NOT delete it" do
          SimpleGitPair::Helper.should_not_receive :save_pairs
        end
      end
    end
  end

  describe "#validate_opts" do
    subject { command.send :validate_opts }

    context "initials have spaces" do
      let(:opts) { ["n g"] }
      it "returns error status and msg" do
        initials, valid_opts, errors = subject
        valid_opts.should be_false
        errors.should_not be_empty
      end
    end

    context "initals are fine" do
      let(:opts) { ["og"] }

      it "returns intials and no error" do
        initials, valid_opts, errors = subject
        initials.should == "og"
      end
    end
  end
end
