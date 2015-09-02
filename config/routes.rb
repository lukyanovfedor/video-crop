Rails.application.routes.draw do
  namespace :api do
    namespace :v1, defaults: { format: 'json' } do
      resources :users, only: :create

      resources :inquiries, only: %i(create index) do
        post 'restart', on: :member
      end
    end
  end

  match '*path', via: %i(get post), to: 'api/v1/api_application#routing_error'
end
