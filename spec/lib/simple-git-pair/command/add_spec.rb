require 'spec_helper'
require 'simple-git-pair/command/add'

describe SimpleGitPair::Command::Add do
  let(:opts) { [] }
  let(:command) { described_class.new opts }

  describe "#run!" do
    subject { command.run! }
    before { command.stub :puts }

    it_should_behave_like "command that ensures that pairs file exists"

    context "there is a pairs file" do
      context "and there is already a pair with the same initials" do
        let(:opts) { ["ng", "New", "Guy"] }
        before { SimpleGitPair::Helper.stub(:read_pairs).and_return({"ng" => "Already Exists"}) }

        context "and user agrees to override" do
          before { command.stub(:agree).and_return true }
          it "overrides the pair" do
            SimpleGitPair::Helper.should_receive(:save_pairs).with({"ng" => "New Guy"})
            subject
          end
        end

        context "and user dissagrees to override" do
          before { command.stub(:agree).and_return false }
          it "doesn't override and exits" do
            SimpleGitPair::Helper.should_not_receive :save_pairs
            expect {subject}.to raise_error SystemExit
          end
        end
      end

      context "and there is NO pair with same initials" do
        let(:opts) { ["ng", "New", "Guy"] }
        before { SimpleGitPair::Helper.stub(:read_pairs).and_return({"og" => "Old Guy"}) }

        it "adds a pair" do
          SimpleGitPair::Helper.should_receive(:save_pairs).with({"og" => "Old Guy", "ng" => "New Guy"})
          subject
        end
      end
    end
  end

  describe "#validate_opts" do
    subject { command.send :validate_opts }

    context "initials have spaces" do
      let(:opts) { ["n g", "New_Guy"] }
      it "returns error status and msg" do
        initials, fullname, valid_opts, errors = subject
        valid_opts.should be_false
        errors.should_not be_empty
      end
    end

    context "full name is not passed in" do
      let(:opts) { ["ng"] }
      it "returns error status and msg" do
        initials, fullname, valid_opts, errors = subject
        valid_opts.should be_false
        errors.should_not be_empty
      end
    end

    context "initals and fullname are fine" do
      let(:opts) { ["ng", "New", "Awesome", "Guy"] }

      it { expect {subject}.to_not raise_error RuntimeError }

      it "treats all options after intials as a fullname" do
        intials, fullname = subject
        fullname.should == "New Awesome Guy"
      end
    end
  end
end
