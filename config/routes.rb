Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post '/readings', to: 'readings#create'
      get '/readings/:id/latest', to: 'readings#latest'
      get '/readings/:id/cumulative_count', to: 'readings#cumulative'
    end
  end
end
