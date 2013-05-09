class VarchWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(payload)
    Requests.request_to_varch(payload)
  end
end
