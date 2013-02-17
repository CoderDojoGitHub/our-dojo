Rails.application.config.middleware.use OmniAuth::Builder do
  provider :githubteammember, ENV['GITHUB_CLIENT_ID'], ENV['GITHUB_CLIENT_SECRET'], :scope => 'user'
end

OmniAuth.config.on_failure = Proc.new { |env|
  if env['omniauth.error'].kind_of? OmniAuth::Strategies::OAuth2::CallbackError
    [302, {'Location' => '/', 'Content-Type'=> 'text/html'}, []]
  end
}