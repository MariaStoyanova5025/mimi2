Rails.application.routes.draw do
  resources :messages
  resources :rsas
  post '/rsas' => 'rsas#newKey'
	get '/rsas/:id' => 'rsas#printKey'
  post '/rsas/:id/encrypt_messages/' => 'messages#encryptMessages'
  
  get '/rsas/:id/encrypt_messages/:id' => 'messages#printEncryptMessages'
  post '/rsas/:id/decrypt_messages/' => 'messages#decryptMessages'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
