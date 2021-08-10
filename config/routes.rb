Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resource :forecast, only: :show
      resource :backgrounds, only: :show
      
      resource :users, controller: :registration, module: :users, only: :create

      namespace :sessions do
      end
    end
  end
end
