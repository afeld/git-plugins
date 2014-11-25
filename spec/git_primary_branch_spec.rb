describe 'git-primary-branch' do
  it "uses an arbitrary branch when it's the only one on remote" do
    `git init remote_repo`
    branch = "rand-#{rand(100)}"
    Dir.chdir('remote_repo') do
      `git commit --allow-empty -m "initial commit"`
      `git branch -m #{branch}`
      expect(execute('git branch')).to eq("* #{branch}\n")
    end

    `git remote add origin remote_repo`
    expect(execute('git remote')).to eq("origin\n")
    `git fetch origin`
    expect(execute('git branch -r')).to eq("  origin/#{branch}\n")

    expect(execute('git primary-branch')).to eq("#{branch}\n")
  end
end
