Rails.application.routes.draw do
   root 'books#login'
   post 'books/index' , to: 'books#index', :as => 'index'
end
