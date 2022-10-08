class ProducerHelper
        def send_message(queue_name, params)
            channel = $bunnyConnection.create_channel
            queue = channel.queue(queue_name, durable: true)
            queue.publish(params.to_json, routing_key: queue.name)
        end
    end