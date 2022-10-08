Rails.application.routes.draw do
  resources :applications do
    resources :chats , param: :number do
      resources :messages, param: :number do
        collection do
          get :search
        end
      end
    end
  end
end