Rails.application.routes.draw do
  resources :urls, only: [:new, :create, :show, :edit, :index,:redirect]
  root 'urls#new'
  get '/:short_url', to: 'urls#redirect', as: 'redirect'
end

