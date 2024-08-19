Rails.application.routes.draw do
  namespace :api do
    resources :games, only: [:create, :index, :show]
    get '/kills-by-means', to: 'games#kills_by_means'
    resources :players, only: [:index, :show]
  end
end
