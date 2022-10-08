class MessageWorker
    include Sneakers::Worker
    from_queue $messageQueue

    def work(message_data)
            message_json = JSON.parse(message_data)
            if message_json.action == "create"
            message_params = message_json.except(:action)
            message = message.new(message_params)
            message.save!
            else
            #TODO
            message_params = message_json.except(:action)
            message = Message.update(message_params)
             end
            ack!
          end
end

