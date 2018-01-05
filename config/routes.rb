Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post 'login', to: "sessions#login"
      post 'signup', to: 'users#create'
      
      scope 'users' do
        get 'show', to: 'users#show'
        patch 'update', to: 'users#update'
      end

      scope 'vaults' do
        get 'show', to: 'vaults#show'
      end

      scope 'codes' do
        get 'user', to: 'codes#user'
        post 'buy', to: 'codes#buy'
      end

      scope 'transactions' do
        patch 'save', to: 'transactions#save'
        patch 'transfer', to: 'transactions#transfer'
      end
    end
  end
end
