describe 'git-primary-branch' do
  def to_branch_list(branches_str)
    branches_str.split(/\n/).map(&:strip).sort
  end

  def branches
    to_branch_list(execute('git branch'))
  end

  def create_branches(primary: 'master', secondary: nil)
    `git commit --allow-empty -m "initial commit"`
    `git branch -m #{primary}`
    if secondary
      `git branch #{secondary}`
      expect(branches).to eq(["* #{primary}", secondary])
    else
      expect(branches).to eq(["* #{primary}"])
    end
  end

  def random_branch_name
    "rand-#{rand(100)}"
  end

  describe "with a remote" do
    def remote_branches
      to_branch_list(execute('git branch -r'))
    end

    def create_remote(primary: 'master', secondary: nil)
      Dir.chdir('remote_repo') do
        create_branches(primary: primary, secondary: secondary)
      end
    end

    def add_remote
      `git remote add origin remote_repo`
      expect(execute('git remote')).to eq("origin\n")
      `git fetch origin`
    end

    def validate_remote_branches(branches)
      branches = branches.map{|b| "origin/#{b}" }.sort
      expect(remote_branches).to eq(branches)
    end

    def set_up_remote(primary: 'master', secondary: nil)
      create_remote(primary: primary, secondary: secondary)
      add_remote

      branches = [primary, secondary].compact
      validate_remote_branches(branches)
    end

    before do
      `git init remote_repo`
    end

    it "uses an arbitrary branch when it's the only one" do
      branch = random_branch_name
      set_up_remote(primary: branch)
      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end

    it "favors `master` over `gh-pages`" do
      set_up_remote(secondary: 'gh-pages')
      expect(execute('git primary-branch')).to eq("master\n")
    end

    it "favors `gh-pages` over others" do
      branch = random_branch_name
      set_up_remote(primary: 'gh-pages', secondary: branch)
      expect(execute('git primary-branch')).to eq("gh-pages\n")
    end
  end

  describe "without a remote" do
    it "uses an arbitrary branch when it's the only one" do
      branch = random_branch_name
      create_branches(primary: branch)
      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end

    it "favors `master` over `gh-pages`" do
      create_branches(secondary: 'gh-pages')
      expect(execute('git primary-branch')).to eq("master\n")
    end

    it "favors `gh-pages` over others" do
      branch = random_branch_name
      create_branches(primary: 'gh-pages', secondary: branch)
      expect(execute('git primary-branch')).to eq("gh-pages\n")
    end
  end
end
