Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  #resources :auths, only: [:create]
  resources :kinds

  #api_version(:module => "V1", :header => {:name => "X-Version", :value => "1.0"}) do
  constraints subdomain: 'v1' do
    scope module: 'v1'
      resources :contacts do
        resource :kind, only: [:show]
        resource :kind, only: [:show], path: 'relationships/kind'

        resource :phones, only: [:show]
        resource :phones, only: [:show], path: 'relationships/phones'
        
        resource :phone, only: [:show, :update, :create, :destroy]
        resource :phone, only: [:show, :update, :create, :destroy], path: 'relationships/phones'

        resource :address, only: [:show, :update, :create, :destroy]
        resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      end
    end
  end

  #api_version(:module => "V2", :header => {:name => "X-Version", :value => "2.0"}) do
  constraints subdomain: 'v2' do
    scope module: 'v2'
      resources :contacts do
        resource :kind, only: [:show]
        resource :kind, only: [:show], path: 'relationships/kind'

        resource :phones, only: [:show]
        resource :phones, only: [:show], path: 'relationships/phones'
        
        resource :phone, only: [:show, :update, :create, :destroy]
        resource :phone, only: [:show, :update, :create, :destroy], path: 'relationships/phones'

        resource :address, only: [:show, :update, :create, :destroy]
        resource :address, only: [:show, :update, :create, :destroy], path: 'relationships/address'
      end
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
