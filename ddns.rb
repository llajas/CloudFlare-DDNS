require 'cloudflare'
require 'net/http'
require 'uri'
require 'timeout'
require 'logger'

# Create a new logger that logs to stdout
logger = Logger.new(STDOUT)

# Evironment Variables
cloudflare_api_key = ENV['CLOUDFLARE_API_KEY'] # Cloudflare API Key (Obtained from '')
cloudflare_email = ENV['CLOUDFLARE_EMAIL'] # Email used to login into Cloudflare account
domain_name = ENV['DOMAIN_NAME'] # Domain to update
dns_record_name = ENV['DNS_RECORD'] # DNS record to update

# Endpoint to check IP
ip_check_endpoint = 'http://icanhazip.com'

# Function to get IP from a URL
def get_ip(url, logger)
  uri = URI(url)
  res = Net::HTTP.get_response(uri)
  res.body if res.is_a?(Net::HTTPSuccess)
rescue Timeout::Error
  logger.error "Timeout error when accessing #{url}"
rescue StandardError => e
  logger.error "Error when accessing #{url}: #{e}"
end

# Get IP from the endpoint
new_ip_address = get_ip(ip_check_endpoint, logger)

# Connect to Cloudflare
cf = Cloudflare.connect(key: cloudflare_api_key, email: cloudflare_email) do |connection|
  zone = connection.zones.find_by_name(domain_name)
  record = zone.dns_records.find_by_name(dns_record_name)

  if record.content != new_ip_address.strip
    # Update the record's IP address
    updated_record = record.update_content(new_ip_address.strip)
    logger.info "Updated DNS record: #{updated_record[:name]} with new IP #{new_ip_address.strip}"
  else
    logger.info "No change in IP address for DNS record: #{record.name}"
  end
end

