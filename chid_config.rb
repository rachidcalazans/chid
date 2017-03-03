require 'singleton'
require 'yaml'

class ChidConfig
  #include Singleton

  attr_reader :chid_path, :home_path, :chid_config_path

  def initialize
    @chid_path = Dir.pwd
    @home_path = File.expand_path("~/")
    @chid_config_path = File.join(home_path, '.chid.config')
  end

  def configure
    create_chid_alias_on_bashrc
    create_an_empty_chid_config_file
  end

  def username
    on_linux { return  %x[echo $USER].strip }
    on_osx   { return  %x[echo $(logname)].strip }
  end

  def on_linux
    if  platform =~ /Linux/
      yield
    end
  end

  def on_osx
    if  platform =~ /Darwin/
      yield
    end
  end

  def platform
    %x{echo $(uname -s)}.strip
  end

  private
  def create_chid_alias_on_bashrc
    print "Creating the chid alias on your "
    print ".bashrc\n\n".blue

    File.open(File.join(home_path, '.bashrc'), 'a') do |file|
      file.write "\nalias chid='rake -f #{chid_path}/Rakefile'" unless chid_config_file_exist?
    end
  end

  def chid_config_file_exist?
    File.exist?(chid_config_path)
  end

  def create_an_empty_chid_config_file
    File.open(chid_config_path, 'w')
  end

  # Not using
  def create_os_info
    os_info = {
      os_info: {
        platform: platform,
        username: username
      }
    }

    chid_config_path = File.join(home_path, '.chid.config')
    File.open(chid_config_path, 'w') do |file|
      YAML.dump(os_info, file)
    end

  end

end
