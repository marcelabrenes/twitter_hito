class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy create_rt ]

  # GET /tweets or /tweets.json
  def index
    @tweets = Tweet.all.page(params[:page])
    @tweet = Tweet.new
  end

  # GET /tweets/1 or /tweets/1.json
  def show
    
  end

  # GET /tweets/new
  def new
    @tweet = Tweet.new
  end

  # GET /tweets/1/edit
  def edit
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)

    respond_to do |format|
      if @tweet.save
        format.html { redirect_to @tweet, notice: "Tweet was successfully created." }
        format.json { render :show, status: :created, location: @tweet }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tweets/1 or /tweets/1.json
  def update
    respond_to do |format|
      if @tweet.update(tweet_params)
        format.html { redirect_to @tweet, notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    @tweet.destroy
    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_rt
    create_rt = params[:tweet][:retweeted]
    tweet_id = params[:tweet][:id] 

    if create_rt
      original_tweet_content = Tweet.find(tweet_id).content
      @tweet.retweeted = true
      @tweet.original_tweet_id = tweet_id
      @tweet.contents = original_tweet_content
    end

    if @tweet.save
      flash[:alert] = "Se creo exitosamente"
      redirect_to root_path
    else
      flash[:alert] = "Algo paso, intentalo de nuevo"
      render 'new'
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:content, :image, :user_id, :name, :page, :retweet_id)
    end
end