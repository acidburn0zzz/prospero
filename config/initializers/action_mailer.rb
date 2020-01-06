# Required to generate URLs in e-mail views
# See https://guides.rubyonrails.org/action_mailer_basics.html#generating-urls-in-action-mailer-views
ActionMailer::Base.default_url_options = {
  host: APP_CONFIG['mailer']['url_options']['host']
}
if APP_CONFIG['port'].present?
  ActionMailer::Base.default_url_options[:port] =
    APP_CONFIG['mailer']['url_options']['port']
end
