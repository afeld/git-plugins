describe 'git-primary-branch' do
  describe "with a remote" do
    def set_up_remote
      `git remote add origin remote_repo`
      expect(execute('git remote')).to eq("origin\n")
      `git fetch origin`
    end

    before do
      `git init remote_repo`
    end

    it "uses an arbitrary branch when it's the only one" do
      branch = "rand-#{rand(100)}"
      Dir.chdir('remote_repo') do
        `git commit --allow-empty -m "initial commit"`
        `git branch -m #{branch}`
        expect(execute('git branch')).to eq("* #{branch}\n")
      end

      set_up_remote
      expect(execute('git branch -r')).to eq("  origin/#{branch}\n")

      expect(execute('git primary-branch')).to eq("#{branch}\n")
    end

    it "favors `master` over `gh-pages`" do
      Dir.chdir('remote_repo') do
        `git commit --allow-empty -m "initial commit"`
        `git branch gh-pages`
        expect(execute('git branch')).to eq("  gh-pages\n* master\n")
      end

      set_up_remote
      expect(execute('git branch -r')).to eq("  origin/gh-pages\n  origin/master\n")

      expect(execute('git primary-branch')).to eq("master\n")
    end

    it "favors `gh-pages` over others" do
      branch = "rand-#{rand(100)}"
      Dir.chdir('remote_repo') do
        `git commit --allow-empty -m "initial commit"`
        `git branch -m gh-pages`
        `git branch #{branch}`
        expect(execute('git branch')).to eq("* gh-pages\n  #{branch}\n")
      end

      set_up_remote
      expect(execute('git branch -r')).to eq("  origin/gh-pages\n  origin/#{branch}\n")

      expect(execute('git primary-branch')).to eq("gh-pages\n")
    end
  end
end
