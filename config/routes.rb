# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  root 'events#index'

  # Errors
  match '/403', to: 'errors#forbidden', via: :all
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Notifications / Messages
  resources :notifications, only: [:index]

  # Events / Participations
  resources :events, shallow: true do
    resources :participations, only: %i[index create update destroy]
  end

  post 'events/notify', to: 'participations#notify', as: 'notify_participants'

  # Users
  get 'created-events', to: 'users#created_events', as: 'created_events'
  get 'joined-events', to: 'users#joined_events', as: 'joined_events'

  get 'blacklist', to: 'users#blacklist', as: 'blacklist'
  post 'blacklist/:id', to: 'users#add_to_blacklist', as: 'add_to_blacklist'
  delete 'blacklist/:id', to: 'users#remove_from_blacklist', as: 'remove_from_blacklist'

  # Chat
  namespace :chat do
    resources :rooms, shallow: true do
      resources :messages, as: 'chat_messages'
    end
  end
end
