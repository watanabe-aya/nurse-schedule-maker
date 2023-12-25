Rails.application.routes.draw do

  namespace :admin do
    get 'wards/new'
  end
  #管理者用
  devise_for :admins,skip: [:passwords,], controllers: {
    registrations: "admin/registrations",
    sessions: "admin/sessions"
  }

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :patients, only: [:new, :create, :destroy]
    resources :nurses, only: [:index, :update]
    resources :admins, only: [:edit, :update]
    resources :wards, only: [:new, :create, :update, :destroy]
  end


  #看護師用
  devise_for :nurses,skip: [:passwords,], controllers: {
    registrations: "nurse/registrations",
    sessions: "nurse/sessions"
  }

  scope module: :nurse do
    root 'homes#top', as: 'top'
    resources :nurses, only: [:update]
    get 'nurses/mypage' => 'nurses#show', as: 'mypage'
    resources :schedules, only: [:show, :index, :create, :destroy] do
      resources :reviews, expect: [:show, :new, :edit]
    end
    post 'nurses/reviews/confirm' => 'reviews#confirm'

    resources :task_lists, only: [:create, :destroy] do
      resources :tasks, expect: [:index, :show] do
        member do
          patch 'update_status'
        end
      end
    end
  end

end
