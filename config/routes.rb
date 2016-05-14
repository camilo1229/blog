Rails.application.routes.draw do

  resources "contacts", only: [:new, :create]

  resources :categories

  resources :articles do
    resources :comments, only: [:create, :destroy, :update] #comments es sub_recurso de articles, pertenece a este.
  end

  devise_for :users
  root 'articles#index'

  get "/dashboard", to: "welcome#dashboard"
  put "/articles/:id/publish", to: "articles#publish" #Publicar es una accion q va a modificar un archivo ya existente asi q se usa el verbo o accion put para editar.
end
