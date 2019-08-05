Rails.application.routes.draw do
  get 'new', to: 'games#new'
  post 'new', to: 'games#score', as: :score
end
