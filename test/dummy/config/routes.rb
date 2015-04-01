Rails.application.routes.draw do
  get '/ping', to: 'site#ping'
end
