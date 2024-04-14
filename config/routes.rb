#routes.rb
Rails.application.routes.draw do
  resources :pokemons
  resources :vape_products

  get 'fetch_pokemons', to: 'pokemons#fetch_pokemons'
  get 'test_actions', to: 'pokemons#test_action'
  match 'clear_pokemons', to: 'pokemons#clear_pokemons', via: [:get, :post]
  get 'layout' => 'vape_products#layout'
  get 'layout2' => 'vape_products#layout2'
  get 'layout3' => 'vape_products#layout3'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html


  # Defines the root path route ("/")
  # root "posts#index"
  resources :vape_products do
  collection do
    get 'import', to: 'vape_products#import'
    get 'export_csv', to: 'vape_products#export', defaults: { format: 'csv' }
  end
end

  get 'vape_products/category/:category', to: 'vape_products#show_category', as: 'category'
  root 'pokemons#index'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


end
