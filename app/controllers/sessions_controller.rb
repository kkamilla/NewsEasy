class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json

  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to "/users/show", :notice => "Logged in!"
      #redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end

  end

  def new

  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  def index
    @sessions = Session.all
    if user
      session[:user_id] = user.id
      render @newsfeeds, :notice => "Logged in!"
      #redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @sessions }
    end
  end

  # GET /sessions/1
  # GET /sessions/1.json
  def show
    @session = Session.find(params[:id])
      redirect_to "user/show"
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @session }
    end
  end


  # GET /sessions/1/edit
  def edit
    @session = Session.find(params[:id])
  end

  # POST /sessions
  # POST /sessions.json


  # PUT /sessions/1
  # PUT /sessions/1.json
  def update
    @session = Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to @session, notice: 'Session was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @session.errors, status: :unprocessable_entity }
      end
    end
  end

  end
