Rails.application.routes.draw do
  devise_for :users, :controllers => {:registrations => "registrations"}

  resources :lists, except: [:edit, :new] do
    resources :tasks, only: [:show, :create, :update, :destroy]
  end

  # For tasks that belong to no list
  resources :tasks, only: [:create, :destroy, :index, :update]
  patch '/tasks/:id/complete', to: 'tasks#toggle_completion', as: 'task_complete'
  patch '/lists/:list_id/tasks/:id/complete', to: 'tasks#toggle_completion', as: 'list_task_complete'



  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
