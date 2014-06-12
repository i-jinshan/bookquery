Rails.application.routes.draw do
   root 'books#login'
   get 'books/index' , to: 'books#index', :as => 'index'
end
