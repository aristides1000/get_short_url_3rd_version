require "browser"

class UrlsController < ApplicationController
  def index
    @url = Url.new
    @urls =  Url.all.order('created_at DESC').limit(10)
  end

  def create
    url =  params[:url];
    @url =Url.all
    keyCode = (0...5).map { (65 + rand(26)).chr }.join
    while (!@url.find_by(short_url: keyCode).nil?)
      keyCode = (0...5).map { (65 + rand(26)).chr }.join
    end
    @urls = Url.new(original_url: url[:original_url], short_url: keyCode, clicks_count: 0 )
    if @urls.save
      redirect_to root_path
    else
      flash[:notice] = 'Invalid Url, empty or invalid url formats are not allowed!'
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @url = Url.find_by(short_url: params[:url])
    if (@url)
      @clicks = @url.clicks.order('created_at ASC').current_month
      dailyClicks = Hash.new
      browser = Hash.new
      platform = Hash.new
      @clicks.each do |click|
        dailyClicks[click.created_at.to_s[...10]] = dailyClicks[click.created_at.to_s[...10]] ? dailyClicks[click.created_at.to_s[...10]] + 1 : 1
        browser[click.browser] = browser[click.browser] ? browser[click.browser] + 1 : 1
        platform[click.platform] = platform[click.platform] ? platform[click.platform] + 1 : 1
      end
      @daily_clicks = dailyClicks.map{ |key, value| [key, value] }
      @browsers_clicks = browser.map{ |key, value| [key, value] }
      @platform_clicks = platform.map{ |key, value| [key, value] }
    else
      render plain: '404 page not found!!...'
    end
  end

  def visit
    @message = 'redirect'
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    short_url =  params[:short_url]
    @url = Url.find_by(short_url: short_url)
    if (@url)
      @clicks = Click.new(url_id: @url.id, platform: browser.platform.name, browser: browser.name)
      if (@clicks.save)
        clickCount = @url.clicks.count
        @url.update(clicks_count: clickCount)
      else
        @message = 'Unable'
      end
    else
      @message = '404'
    end
  end
end
