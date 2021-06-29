require 'fileutils'

WORKING_DIR = File.expand_path('../../tmp/scratch', __FILE__)

RSpec.configure do |config|
  config.order = 'random'
  config.raise_errors_for_deprecations!

  config.before do
    FileUtils.rm_rf(WORKING_DIR)
    init_repo
  end
end

def init_repo
  FileUtils.mkdir_p(WORKING_DIR)
  Dir.chdir(WORKING_DIR)
  `git init`
end

def execute(command)
  # ensure the scripts from this repository are used
  script_path = File.join(File.dirname(__FILE__), '..', 'bin')
  `PATH=#{script_path}:$PATH #{command}`
end
