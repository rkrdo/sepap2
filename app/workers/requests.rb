# Defines the functions to make a request to Deb and to Varch
# Coded by: Miguel Cervera
class Requests

  # Function to make a request to Deb, it has an optional parameter that is used to make a correctly
  # handling of errors, depending if this is called from the toolkit or from Sidekiq
  def self.request_to_deb(payload, toolkit = false)
    # Prepare the objects to make a request
    # Set the DEB Server IP in config/servers.yml
    uri = URI.parse(SERVERS[:deb])
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    
    # The timeout is 15 seconds, just because of reasons.
    http.open_timeout = 15
    http.read_timeout = 15

    begin
      response =  http.request(req)
      return response
    rescue Exception
      if toolkit
        # if the call to this function comes from the toolkit, then we return nil.
        return nil
      else
        # if it comes from else where, then we raise an Exception in order for Sidekiq to catch it.
        raise Exception, "Deb is out of sigh."
      end
    end
  end
  
  # Function to make a request to Varch.
  def self.request_to_varch(payload)
    # Prepare the objects to make a request
    # Set the DEB Server IP in config/servers.yml
    uri = URI.parse(SERVERS[:varch])
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 30
    http.read_timeout = 30
    
    begin
      http.request(req)
    rescue Exception => error
      # If there is an error, we publish on the channel to print the error.
      json = ActiveSupport::JSON.decode(payload)
      channel = json["params"]["channel"]
      pub = Danthes.publish_to channel, :message => error.message
    end
  end
end
