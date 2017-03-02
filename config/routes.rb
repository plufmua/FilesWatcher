Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :data_sets, only: [:index, :show] do
    post 'update_files', on: :collection
  end
  root to: 'data_sets#index'
end
