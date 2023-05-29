class UrlsController < ApplicationController

  def index
    @urls = Url.all
  end

  def new
    @url = Url.new
  end

  def create
    @url = Url.find_by(long_url: url_params[:long_url])

    if @url
      redirect_to @url, notice: 'URL already exists.'
    else
      @url = Url.new(url_params)
      @url.short_url = generate_short_url

      if @url.save
        redirect_to @url, notice: 'URL was successfully shortened.'
      else
        render :new
      end
    end
  end

  def redirect
    @url = Url.find_by_short_url(params[:short_url])

    if @url
      redirect_to @url.long_url, allow_other_host: true
    else
      # Handle the case when the short URL is not found
      redirect_to root_path, alert: 'Short URL not found.'
    end
  end


  def show
    @url = Url.find(params[:id])
    redirect_to @url.long_url, allow_other_host: true and return if params[:redirect].present?
  end


  private

  def url_params
    params.require(:url).permit(:long_url)
  end

  def generate_short_url
    SecureRandom.hex(3) # Generates a random 6-character string for simplicity
  end
end
