require 'rufus-scheduler'

scheduler = Rufus::Scheduler::singleton

scheduler.every '50m' do
    Rails.logger.info "Starting Background Counting Job"
    Application.all.each do |application|
        application.chats_count = Chat.where(application_id: application.id).length()
        application.save
    end

    Chat.all.each do |chat|
        chat.messages_count = Message.where(chat_id: chat.id).length()
        chat.save
    end
end

