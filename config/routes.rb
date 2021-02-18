Rails.application.routes.draw do
  devise_for :users

  resources :lists do
    resources :tasks, only: [:show, :new, :create, :update, :destroy]
  end

  get '/tasks', to: 'tasks#index'
  patch '/tasks/:id/complete', to: 'tasks#toggle_completion', as: 'task_complete'
  patch '/lists/:list_id/tasks/:id/complete', to: 'tasks#toggle_completion', as: 'list_task_complete'

  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
