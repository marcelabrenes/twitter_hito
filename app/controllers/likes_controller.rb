class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit destroy ]
  before_action :find_tweet
  before_action :find_like, only: [:destroy]

  # GET /likes or /likes.json
  def index
    @likes = Like.all
  end

  # GET /likes/1 or /likes/1.json
  def show
  end

  # GET /likes/new
  def new
    @like = Like.new
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create
    @like = @tweet.likes.build(user: current_user)
      if @like.save
        redirect_to tweets_path, notice: "Like was successfully created."
      else
        redirect_to like.errors, notice: "Error" 
      end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to tweets_path, notice: "Like was successfully destroyed." }
      format.json { head :no_content }
      if !(already_liked?)
      flash[:notice] = "Cannot unlike"
      else
      @like.destroy
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_like
    @like = Like.find(params[:id])
  end

  def find_tweet
    @tweet = Tweet.find(params[:tweet_id])
  end

  def already_liked?
    Like.where(user_id: current_user.id, tweet_id:
    params[:tweet_id]).exists?
  end

  def find_like
    @like = @tweet.likes.find(params[:id])
  end
  
  # Only allow a list of trusted parameters through.
  def like_params
    params.require(:like).permit(:tweet_id, :user_id, :id)
  end
end