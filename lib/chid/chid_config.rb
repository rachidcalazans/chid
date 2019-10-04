class ChidConfig

  attr_reader :chid_path, :home_path, :chid_config_path

  def initialize
    @chid_path = Dir.pwd
    @home_path = File.expand_path("~/")
    @chid_config_path = File.join(home_path, '.chid.config')
  end

  def self.username
    on_linux { return  %x[echo $USER].strip }
    on_osx   { return  %x[echo $(logname)].strip }
  end

  def self.on_linux
    if  platform =~ /Linux/
      yield
    end
  end

  def self.on_osx
    if  platform =~ /Darwin/
      yield
    end
  end

  def self.platform
    %x{echo $(uname -s)}.strip
  end

  def all_workstations
    data = YAML.load_file chid_config_path
    data[:chid][:workstations]
  end

  def all_tmux_templates
    data = YAML.load_file chid_config_path
    data[:chid][:tmux_templates]
  end

  def destroy_workstations(workstations = [])
    data = YAML.load_file chid_config_path

    workstations.each do |w|
      data[:chid][:workstations].delete_if { |key, value| key == w }
    end

    File.open(chid_config_path, 'w') do |file|
      YAML.dump(data, file)
    end
  end

  def create_workstation(name, apps = [])
    data = YAML.load_file chid_config_path

    data[:chid][:workstations][:"#{name}"] = apps

    File.open(chid_config_path, 'w') do |file|
      YAML.dump(data, file)
    end
  end
end
