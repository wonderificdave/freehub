Freehub::Application.routes.draw do
  resources :organizations 
  
  scope ':organization_key' do
    resources :people do
      collection do
        get :auto_complete_for_person_full_name
      end
    end
  end
  resources :users
  resource :session
  match '/activate/:activation_code' => 'users#activate', :as => :activate
  match '/forgot' => 'users#forgot', :as => :forgot
  match '/reset/:reset_code' => 'users#reset', :as => :reset, :constraints => { :reset_code => /\w+/ }
  resources :tags, :only => :show
  # resources :people do
    # collection do
      # get :auto_complete_for_person_full_name
    # end
  # end

  resources :visits
  resources :services
  resources :notes
  resources :taggings, :only => [:index, :create, :destroy]
  # match ':organization_key/people/new' => 'people#new', :as => :people
  #match ':organization_key/people/:action' => 'people', :as => :people
  match ':organization_key/visits/:year/:month/:day' => 'visits#day', :as => :day_visits, :constraints => { :year => /\d{4}/, :day => /\d{1,2}/, :month => /\d{1,2}/ }
  match ':organization_key/reports' => 'reports#index', :as => :reports
  match ':organization_key/reports/:action' => 'reports#index', :as => :report
  match ':organization_key' => 'organizations#update', :via => :put
  match ':organization_key' => 'organizations#destroy', :via => :delete
  match ':organization_key' => 'organizations#show', :as => :organization_key
  match ':organization_key/edit' => 'organizations#edit', :as => :edit_organization_key
  root :to => 'organizations#index'
# is this needed?
  match '/:controller(/:action(/:id))'
end
