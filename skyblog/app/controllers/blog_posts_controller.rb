class BlogPostsController < ApplicationController
    before_action :authenticate_user
  
    def index
      render json: @current_user.blog_posts.map { |p| serialize_post(p) }
    end
  
    def create
      post = @current_user.blog_posts.new(blog_post_params)
  
      if post.save
        post.photo.attach(params[:photo]) if params[:photo]
        render json: serialize_post(post), status: :created
      else
        render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def update
        post = @current_user.blog_posts.find(params[:id])
      
        if post.update(blog_post_params)
          # if updating photo, attach it again
          if params[:photo].present?
            post.photo.attach(params[:photo])
          end
      
          render json: serialize_post(post), status: :ok
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
    end
      
    def destroy
        post = @current_user.blog_posts.find(params[:id])
        post.destroy
        render json: { message: "Blog post deleted." }, status: :ok
    end
      
    private
  
    def blog_post_params
      params.permit(:content, :photo)
    end
  
    def serialize_post(post)
      {
        id: post.id,
        content: post.content,
        photo_url: post.photo.attached? ? url_for(post.photo) : nil,
        created_at: post.created_at
      }
    end
end
  