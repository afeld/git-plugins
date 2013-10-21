require 'spec_helper'

describe 'git-github-repo' do
  it "handles git:// remotes" do
    `git remote add origin git@github.com:afeld/git-plugins-test.git`
    `git github-repo`.should eq("afeld/git-plugins-test\n")
  end

  it "handles https:// remotes that end in .git" do
    `git remote add origin https://github.com/afeld/git-plugins-test.git`
    `git github-repo`.should eq("afeld/git-plugins-test\n")
  end

  it "handles https:// remotes that don't end in .git" do
    `git remote add origin https://github.com/afeld/git-plugins-test`
    `git github-repo`.should eq("afeld/git-plugins-test\n")
  end

  it "fails for paths"

  it "fails for non-github git:// remotes"
end
