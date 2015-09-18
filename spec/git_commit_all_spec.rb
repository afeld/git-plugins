describe 'git-commit-all' do
  before do
    `touch file.txt`
    `git add file.txt`
    `git commit -m "foo"`
  end

  def expect_clean_working_dir
    expect(execute('git status --short')).to be_empty
  end

  it "includes changed files" do
    `echo "some text" >> file.txt`
    execute('git commit-all -m "bar"')
    expect_clean_working_dir
  end

  it "includes added files" do
    `touch file2.txt`
    execute('git commit-all -m "bar"')
    expect_clean_working_dir
  end

  it "includes deleted files" do
    `rm file.txt`
    execute('git commit-all -m "bar"')
    expect_clean_working_dir
  end
end
