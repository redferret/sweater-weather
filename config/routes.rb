Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resource :forecast, only: :show
      resource :backgrounds, only: :show
      
      namespace :users do
      end

      namespace :sessions do
      end
    end
  end
end
