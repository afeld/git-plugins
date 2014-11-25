describe 'git-github-repo' do
  it "handles git:// remotes" do
    `git remote add origin git@github.com:afeld/git-plugins-test.git`
    expect(execute('git github-repo')).to eq("afeld/git-plugins-test\n")
  end

  it "handles https:// remotes that end in .git" do
    `git remote add origin https://github.com/afeld/git-plugins-test.git`
    expect(execute('git github-repo')).to eq("afeld/git-plugins-test\n")
  end

  it "handles https:// remotes that don't end in .git" do
    `git remote add origin https://github.com/afeld/git-plugins-test`
    expect(execute('git github-repo')).to eq("afeld/git-plugins-test\n")
  end

  it "fails for paths"

  it "fails for non-github git:// remotes"
end
