Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  
  root to: "products#homepage"
  
  resources :products, only: [:index, :show] do
    resources :order_items, only: [:create]
  end
  
  resources :wizards do
    resources :products, only: [:index]
  end
  
  resources :categories do
    resources :products, only: [:index]
  end
  
end
