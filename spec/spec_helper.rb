WORKING_DIR = 'tmp/scratch'

RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.order = 'random'

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
