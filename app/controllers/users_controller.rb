class UsersController < ApplicationController
  # GET /users
  # GET /users.json
  def new
    @user = User.new
  end
  def following
    @title = "Following"
    @user = User.find(params[:id])
    #@users = @user.followed_users.paginate(page: params[:page])
    render 'show_follow'
  end
  def create

    @user = User.new(params[:user])
    if @user.save
      #redirect_to root_url , :notice => "Signed up!"
      render "users/show"
    else
      render "new"
    end
  end
  def feed
    # This is preliminary. See "Following users" for the full implementation.
    Newsfeed.where("user_id = ?", id)
  end
  def index
    @users = User.all
    require 'nokogiri'
    require 'open-uri'
    #require "http"

    doc = Nokogiri::XML(open("http://sports.yahoo.com/top/rss.xml"))

    @newsfeeds = doc.xpath('//item').map do |i|
      {'title' => i.xpath('title').inner_text,
       'link' => i.xpath('link').inner_text,
       'description' => i.xpath('description').inner_text
      }
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(current_user.id)
#redirect_to  "newsfeeds/index"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
