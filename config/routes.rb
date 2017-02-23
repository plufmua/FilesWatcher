Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :data_sets, only: [:index, :show] do
    get 'update_files', on: :collection
    # match 'update_files' => 'data_sets#update_files', :via => :get
  end
  root to: 'data_sets#index'
end
