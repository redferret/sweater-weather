Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resource :forcast, only: :show

      namespace :users do
      end

      namespace :sessions do
      end
    end
  end
end
