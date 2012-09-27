require 'spec_helper'
require 'simple-git-pair/command/list'

describe SimpleGitPair::Command::List do
  let(:command) { described_class.new }

  describe "#run!" do
    subject { command.run! }

    it_should_behave_like "command that ensures that pairs file exists"

    context "there are available pairs" do
      before { SimpleGitPair::Helper.stub(:read_pairs).and_return({"od" => "One Dude", "ad" => "Another Dude"}) }
      it "displays them" do
        command.should_receive(:puts).with("od: One Dude")
        command.should_receive(:puts).with("ad: Another Dude")
        subject
      end
    end

    context "there is NO available pairs" do
      before { SimpleGitPair::Helper.stub(:read_pairs).and_return({}) }
      it "complains" do
        command.should_receive(:puts).with("No pairs available. Use 'git pair add' to add more pairs.")
        subject
      end
    end
  end
end
