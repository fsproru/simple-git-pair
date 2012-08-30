require 'simple-git-pair/helper'

describe SimpleGitPair::Helper do
  describe :names_for do
    before do
      YAML.stub(:load_file).and_return(
        { "pm" => "Pac Man", "sm" => "Super Mario" }
      )
    end

    subject {described_class.names_for initials}

    context "there is NO user in pairs file" do
      let(:initials) { ["non_existent_pair"] }
      it { expect { subject }.to raise_error }
    end

    context "there are users in pairs file" do
      let(:initials) { ["pm", "sm"] }
      it 'returns array with user names' do
        subject.should == ["Pac Man", "Super Mario"]
      end
    end
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
