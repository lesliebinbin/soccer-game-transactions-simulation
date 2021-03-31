class TransactionPublishJob < ApplicationJob
  queue_as :default

  def perform(*args)
    ActionCable.server.broadcast 'message_channel', { func: 'Transaction#update_messages' }
  end
end
