class PostsController < ApplicationController

	def new
		if current_user.connections.any?
			@post = Post.new
		else
			redirect_to dashboard_path, notice: "Please connect to a social network first"
		end
	end

	def create
		@post = current_user.posts.new(post_params)

		respond_to do |format|
			if @post.save
				format.html {redirect_to dashboard_path, notice: "Post was successfully created"}
			else
				format.html { render :new}
			end
		end
	end

	private

	def post_params
		params.require(:post).permit(:content, :scheduled_at, :state, :user_id, :facebook, :twitter)
	end

end
