# Require all files inside the lib folder only
%w(lib).each do |inc|
  dir = File.join(File.dirname(__FILE__), inc)
  glob = Dir.glob(dir + "/*.rb")
  glob.each { |r| require r }
end

# Load all rake tasks inside the tasks folder
dir = File.join(File.dirname(__FILE__), 'tasks')
glob = Dir.glob(dir + "/**/*.rake")
glob.each { |r| load r }


# Initialize the default variable to use on all rake tasks
@chid_config = ChidConfig.new

task :default => :chid
