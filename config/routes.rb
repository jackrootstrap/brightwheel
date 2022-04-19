Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/readings', to: 'readings#create'
      get '/readings/:id/latest', to: 'readings#latest', as: 'lasted_device'
      get '/readings/:id/cumulative_count', to: 'readings#cumulative', as: 'cumulative_count'
    end
  end
end
