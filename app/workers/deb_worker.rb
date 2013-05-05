class DebWorker
  include Sidekiq::Worker
  #sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(payload)
    # Sends HTTP post to python webservice that runs the algorithms
    uri = URI.parse('http://192.168.33.10:6666/')
    req = Net::HTTP::Post.new(uri.path, initheader = {'Content-Type' => 'application/json'})
    puts "*******************************"
    puts payload
    req.body = payload

    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 15
    http.read_timeout = 15

    #request = Net::HTTP.post_form(uri, payload)
    begin
      response =  http.request(req)
      puts response.body
      return response
    rescue Exception
      puts "Connection refused"
      return nil
    end
  end
end
