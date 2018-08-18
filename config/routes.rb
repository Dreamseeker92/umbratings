Rails.application.routes.draw do
  get 'ratings/create'
  get 'ip_list', to: 'ip#ip_list'
  get 'best_posts/:rating(/:length)',
      action: :best_posts,
      controller: :posts
  resources :posts, only: :create do
    resources :ratings, only: :create
  end
end
