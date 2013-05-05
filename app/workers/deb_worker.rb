class DebWorker
  include Sidekiq::Worker
  #sidekiq_options queue: "high"
  # sidekiq_options retry: false

  def perform(payload)
    Requests.request_to_deb(payload)
  end
end
