class CommentsController < ApplicationController
  before_filter :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(params[:comment].permit(:name, :body, :image))
    @comment.user_id = current_user.id 
    @comment.save
		redirect_to post_path(@post)
	end
  
  def like
    @user = current_user
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @user.toggle_like!(@comment)
    redirect_to :back
  end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to post_path(@post)
	end
end
