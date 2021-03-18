class LikesController < ApplicationController
  before_action :set_like, only: %i[ show edit update destroy ]
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
    user_id = current_user
  end

  # GET /likes/1/edit
  def edit
  end

  # POST /likes or /likes.json
  def create

    @like = Like.new(like_params)
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @tweet.likes.create(user_id: current_user.id)

    respond_to do |format|
      if @like.save
        format.html { redirect_to @like, notice: "Like was successfully created." }
        format.json { render :show, status: :created, location: @like }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /likes/1 or /likes/1.json
  def update
    respond_to do |format|
      if @like.update(like_params)
        format.html { redirect_to @like, notice: "Like was successfully updated." }
        format.json { render :show, status: :ok, location: @like }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @like.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /likes/1 or /likes/1.json
  def destroy
    respond_to do |format|
      format.html { redirect_to likes_url, notice: "Like was successfully destroyed." }
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
    params.require(:like).permit(:tweet_id, :user_id)
  end
end