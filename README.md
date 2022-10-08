# README

## To run the code for first time
``` 
docker-compose up --build
```

## To run the code in general
``` 
docker-compose up
```
## Environment and Gems:
**Ruby:**
- Using version 5.2.3 as it has more than 13 million downloads for this version.

**Rails:**
- Using version 3.0.2

**MySQL:**
- Using mysql2 gem to deal with database quires through active record.

**Redis:**

- Using redis-rails gem to handle chats and messages counting.

**RabbitMQ:**
- Using Bunny gem.
- Using Sneakers gem to handle Consumer/Worker part
- Having two queues chats and messages

**ElasticSearch:**
- Using 3 gems to handle Models and CallBacks
  - elasticsearch-model
  - elasticsearch-rails
  - elasticsearch-persistence

**Background Recurring Jobs:**
- Using rufus-scheduler gem.
## API Endpoints:
  - **1- For Application:**
  ```
      GET   /applications/
      GET   /applications/{access_token}
      POST  /applications
      PUT   /applications/{access_token}

   ```
- **2- For Chat:**
  ```
      GET   /applications/{access_token}/chats
      GET   /applications/{access_token}/chats/{chat_number}
      POST  /applications/{access_token}/chats/
      PUT   /applications/{access_token}/chats/{chat_number}
      DELETE /applications/{access_token}/chats/{chat_number}
    ```
  - **3- For Message:**
    ```
      GET   /applications/{access_token}/chats/{chat_number}/messages
      GET   /applications/{access_token}/chats/{chat_number}/messages/{message_number}
      GET   /applications/{access_token}/chats/{chat_number}/messages/search?text={text}
      POST  /applications/{access_token}/chats/{chat_number}/messages - body of request {"body": {message_body}}
      PUT   /applications/{access_token}/chats/{chat_number}/messages/{message_number}
      DELETE   /applications/{access_token}/chats/{chat_number}/messages/{message_number}
      GET   /applications/{access_token}/chats/{chat_number}/messages/{message_number}/{text}

## Challenges and suggested solutions:
- **1- Chats and Messages Count:**
  
  - Using background recurring job to handle this count to run every 50 mins and keep 10 mins as a buffer after the database becomes large, so it wouldn't be lagging more than 1 Hour.

-  **2- Many Requests came to System  and may run on Multiple Servers "Race Condition":**

    - Using RabbitMQ to handle this, Having producer that takes chat/message params to create/update and pass it to the queue for each entity , and having a consumer that consume the params from the queues and passing it to database to achieve serializing access to the shared resource "database".

-  **3- Chat and Message Numbering:**

    - Using Redis to handle the counts
    - incr for creating chat/message
    - decr when destroying/deleting chat/message
    - why using incr, decr? Because If the key does not exist, it is set to 0 before performing the operation.
## Known Problems/TODO:
- 1- RabbitMQ must be used when update messge entity.
- 2- Creation Endpoints to be implmented in GoLang
- 3- Writing unit tests