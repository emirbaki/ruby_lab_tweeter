class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[ show edit update destroy ]

  def tweets_by_hashtag
    @tweets = Tweet.includes(:hashtags).where(hashtags: { name: '#'+ params[:hashtag] })
  end

  # GET /tweets or /tweets.json
  def index
    if params[:hashtag]
      hashtag = Hashtag.find_by(name: params[:hashtag])
      @tweets = hashtag ? hashtag.tweets : []
    else
      @tweets = Tweet.all
    end
  end

  # GET /tweets/1 or /tweets/1.json
  def show
  end

  # GET /tweets/new
  def new
    if !session[:user]
      redirect_to tweets_path, :notice => "You have to log in to
      create a new tweet "
      else
      @tweet = Tweet.new
      end
      
  end

  # GET /tweets/1/edit
  def edit
    @tweet = Tweet.find(params[:id])
    if @tweet.user.name != session[:user]
    redirect_to tweets_path, :alert => "You cannot edit another
    user’s tweet!"
    else
    @tweet = Tweet.find(params[:id])
    end
  end

  # POST /tweets or /tweets.json
  def create
    @tweet = Tweet.new(tweet_params)
    @tweet.user = User.find_by name: session[:user]


    respond_to do |format|
      if @tweet.save
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully created." }
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
        format.html { redirect_to tweet_url(@tweet), notice: "Tweet was successfully updated." }
        format.json { render :show, status: :ok, location: @tweet }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @tweet.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tweets/1 or /tweets/1.json
  def destroy
    if @tweet.user.name != session[:user]
      redirect_to tweets_path, :notice => "You cannot delete
      another user’s tweet!"
      else
    @tweet.destroy!

    respond_to do |format|
      format.html { redirect_to tweets_url, notice: "Tweet was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tweet_params
      params.require(:tweet).permit(:text, :user_id, :content, :mentions, :hashtags)
    end
end
