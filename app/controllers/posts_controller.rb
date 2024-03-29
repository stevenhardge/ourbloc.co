class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]
	def index
    unless user_signed_in?
      redirect_to new_user_session_path
    else
      if params[:hashtag]
        @posts = Post.tagged_with(params[:hashtag]).order('created_at DESC')
      else
       # @posts = Post.all.order('created_at DESC')
       following_ids = current_user.followees(User).map(&:id)
       @posts = Post.where(user_id: following_ids).order("created_at DESC")
      end
    end
	end

	def new
		@post = current_user.posts.build
	end

	def create
		@post = current_user.posts.build(post_params)
		
		if @post.save
			redirect_to @post 
      tags = @post.body.scan( SimpleHashtag::Hashtag::HASHTAG_REGEX )
      @post.update_attribute(:tag_list, tags)
		else
			render 'new'
		end
	end

	def show
		@post = Post.find(params[:id])
	end

	def edit
		@post = Post.find(params[:id])
	end

	def update
		@post = Post.find(params[:id])

		if @post.update(params[:post].permit(:title, :image, :body, :tag_list))
      tags = @post.body.scan(/\B#\w+/)
      @post.update_attribute(:tag_list, tags)
			redirect_to @post
		else
			render 'edit'
		end
	end


	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to root_path 
	end

  def likes
    @user = current_user 
    @post = Post.find(params[:id])
    @user.toggle_like!(@post)
    redirect_to :back, notice: "Liked this post successfully!"
  end

  def follow
    @user = current_user
    @post = Post.find(params[:id])
    @postowner = User.find(@post.user.id)
    @user.toggle_follow!(@postowner)
    redirect_to :back, notice: "Followed this post successfully!"
  end

	private

	def post_params
		params.require(:post).permit(:title, :image, :body, :tag_list)
	end
end
