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
    CLONE_DIR = 'cloned_repo'

    def create_clone
      `git clone #{WORKING_DIR} #{CLONE_DIR}`
    end

    it "uses the primary branch" do
      create_branches
      create_clone
      Dir.chdir(CLONE_DIR) do
        expect(execute('git primary-branch')).to eq("master\n")
      end
    end

    it "uses the primary branch when it's something arbitrary" do
      branch = random_branch_name
      create_branches(primary: branch, secondary: 'master')
      create_clone
      Dir.chdir(CLONE_DIR) do
        expect(execute('git primary-branch')).to eq("#{branch}\n")
      end
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
