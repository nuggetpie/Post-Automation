Rails.application.config.middleware.use OmniAuth::Builder do

	provider :twitter, ENV["TWITTER_KEY"], ENV["TWITTER_SECRET"]
	provider :facebook, ENV["FACEBOOK_ID"], ENV["FACEBOOK_SECRET"], scope: 'email,publish_actions'
end

OmniAuth.config.on_failure = Proc.new do |env|
	ConnectionsController.action(:ominauth_failure).call(env)
end