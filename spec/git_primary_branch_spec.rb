describe 'git-primary-branch' do
  describe "with a remote" do
    def to_branch_list(branches_str)
      branches_str.split(/\n/).map(&:strip).sort
    end

    def branches
      to_branch_list(execute('git branch'))
    end

    def remote_branches
      to_branch_list(execute('git branch -r'))
    end

    def set_up_remote(primary: 'master', secondary: nil)
      Dir.chdir('remote_repo') do
        `git commit --allow-empty -m "initial commit"`
        `git branch -m #{primary}`
        if secondary
          `git branch #{secondary}`
          expect(branches).to eq(["* #{primary}", secondary])
        else
          expect(branches).to eq(["* #{primary}"])
        end
      end

      `git remote add origin remote_repo`
      expect(execute('git remote')).to eq("origin\n")
      `git fetch origin`

      if secondary
        expect(remote_branches).to eq(["origin/#{primary}", "origin/#{secondary}"].sort)
      else
        expect(remote_branches).to eq(["origin/#{primary}"])
      end
    end

    before do
      `git init remote_repo`
    end

    it "uses an arbitrary branch when it's the only one" do
      branch = "rand-#{rand(100)}"
      set_up_remote(primary: branch)
      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end

    it "favors `master` over `gh-pages`" do
      set_up_remote(secondary: 'gh-pages')
      expect(execute('git primary-branch')).to eq("master\n")
    end

    it "favors `gh-pages` over others" do
      branch = "rand-#{rand(100)}"
      set_up_remote(primary: 'gh-pages', secondary: branch)
      expect(execute('git primary-branch')).to eq("gh-pages\n")
    end
  end
end
