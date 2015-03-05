if Rails.env == "production"
  require 'sidekiq'

  require 'sidekiq/web'

  Sidekiq::Web.use(Rack::Auth::Basic) do |username, password|
    [username, password] == [SimpleSettings.config[:sidekiq_admin], SimpleSettings.config[:sidekiq_password]]
  end
end
