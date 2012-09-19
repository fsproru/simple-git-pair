shared_examples_for "command that ensures that pairs file exists" do
  context "there is NO pairs file" do
    before { command.stub(:ensure_pairs_file_exists).and_return false }
    it "complains and exit" do
      expect { subject }.to raise_error SystemExit
    end
  end
end
