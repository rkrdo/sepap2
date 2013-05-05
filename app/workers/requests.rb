class Requests
  #define the different request methods between varch, deb and sepap
  
  def self.request_to_deb(payload, toolkit = false)
    uri = URI.parse(SERVERS[:deb])
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15
    
    if toolkit
      # if the quest comes from the toolkit, we need to rescue from the exception
      begin
        response =  http.request(req)
        #puts response.body
        return response
      rescue Exception
        #puts "Connection refused"
        return nil
      end
    else
      # Make the request without worrying about the error if not from toolkit
      # The error will be handled by Sidekiq
      http.request(req)
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
      #puts response.body
      return response
    rescue Exception => error
      #puts "Connection refused"
      return error
    end
  end
end
