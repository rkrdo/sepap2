raw_config = File.read("#{Rails.root}/config/servers.yml")
SERVERS = YAML.load(raw_config)[Rails.env].symbolize_keys
