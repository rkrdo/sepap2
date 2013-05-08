class Requests
  #define the different request methods between varch, deb and sepap

  def self.request_to_deb(payload, toolkit = false)
    uri = URI.parse(SERVERS[:deb])
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15

    begin
      response =  http.request(req)
      return response
    rescue Exception
      # if the call to this function comes from the toolkit, then we return nil.
      # if it comes from else where, then we raise an Exception in order for Sidekiq to catch it.
      if toolkit
        return nil
      else
        raise Exception, "Deb is out of sigh."
      end
    end
  end

  def self.request_to_varch(payload)
    uri = URI.parse(SERVERS[:varch])
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15
    begin
      response =  http.request(req)
      return response
    rescue Exception => error
      return error
    end
  end
end
