# frozen_string_literal: true
Devise.setup do |config|
  config.secret_key = '0ae76f64192ed107d9320ad058343193193d7b69fde4bdcbfc7de13b4f9ec8da28c04c33d76aee963de8c459c8d64b1152fb7e3eeda13a337f9b6d0f99bc1b27'
  config.mailer_sender = 'rykn0wxx@noreply.com'
  require 'devise/orm/active_record'
  config.authentication_keys = [:login]
  # config.request_keys = []
  config.case_insensitive_keys = [:login]
  config.strip_whitespace_keys = [:login]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.pepper = 'a5b410ec8ff4329f60d52079d705f29e496a3f0d59f3ceab256111e9140d656182724e2b108aab6999d1bb218dd7039422ba03e2575ff99bb782295013f923c9'
  config.reconfirmable = false
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 2..128
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  ActiveSupport.on_load(:devise_failure_app) do
    include Turbolinks::Controller
  end
end
