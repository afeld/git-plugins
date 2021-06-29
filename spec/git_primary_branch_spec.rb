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
    REMOTE_REPO_DIR = 'remote_repo'

    def remote_branches
      to_branch_list(execute('git branch -r'))
    end

    def create_remote(primary: 'master', secondary: nil)
      Dir.chdir(REMOTE_REPO_DIR) do
        create_branches(primary: primary, secondary: secondary)
      end
    end

    def add_remote
      `git remote add origin #{REMOTE_REPO_DIR}`
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

    it "uses the primary branch" do
      set_up_remote()
      expect(execute('git primary-branch')).to eq("master\n")
    end

    it "uses the primary branch when it's something arbitrary" do
      branch = random_branch_name
      set_up_remote(primary: branch, secondary: 'master')
      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end
  end

  describe "without a remote" do
    it "uses the local setting" do
      branch = 'foo'
      `git config init.defaultBranch #{branch}`
      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end

    # TODO test global default
  end
end
