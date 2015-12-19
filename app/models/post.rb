class Post < ActiveRecord::Base
	belongs_to :user

	validates_presence_of :content
	validates_presence_of :scheduled_at
	validates_length_of :content, maximum: 140, message: "less than 140 characters please"
	validates_datetime :scheduled_at, :on => :create, :on_or_after => Time.zone.now
	validate :custom_checkbox_validation

	def custom_checkbox_validation
		errors.add(:base, 'Please check atleast one checkbox') unless facebook || twitter
     end

	def to_twitter
		client = Twitter::REST::Client.new do |config|
			config.access_token = self.user.twitter.oauth_token
			config.access_token_secret = self.user.twitter.secret
			config.consumer_key = ENV['TWITTER_KEY']
			config.consumer_secret = ENV['TWITTER_SECRET']
		end
		client.update(self.content)
end

	def to_facebook
		graph = Koala::Facebook::API.new(self.user.facebook.oauth_token)
		graph.put_connections("me", "feed", message: self.content)
	end

end
