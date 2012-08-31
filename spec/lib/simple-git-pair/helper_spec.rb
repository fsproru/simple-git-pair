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

  describe :pairs_file_exists? do
    subject { described_class.pairs_file_exists? }

    context "pairs file exists" do
      before { File.stub(:exist?).and_return true }
      it { should be_true }
    end

    context "there is no pairs file" do
      before { File.stub(:exist?).and_return false }
      it { should be_false }
    end
  end
end
