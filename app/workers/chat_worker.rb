class ChatWorker
    include Sneakers::Worker
    from_queue $chatQueue

    def work(chat_data)
        chat_json = JSON.parse(chat_data)
        if chat_json.action == "create"
        chat_params = chat_json.except(:action)
        chat = Chat.new(chat_params)
        chat.save!
        else
        chat_params = chat_json.except(:action)
        chat = Chat.update(chat_params)
         end
        ack!
      end
end