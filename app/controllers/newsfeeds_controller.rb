class NewsfeedsController < ApplicationController
  attr_accessor  :link, :title ,:description
  # GET /newsfeeds
  # GET /newsfeeds.json

  def index
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
   # @newsfeeds = Newsfeed.all

#       Newsfeed.add(@newsfeeds)
      respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @newsfeeds }
      end
    p @newsfeeds
   end
  def correct_user
    @newsfeeds = current_user.newsfeed.find_by(id: params[:id])
    redirect_to root_url if @newsfeeds.nil?
  end
  # GET /newsfeeds/1
  # GET /newsfeeds/1.json
  def show
    @newsfeeds = Newsfeed.find(params[:id])

   # require 'xml/xslt'
 #xslt = XML::XSLT.new()
  # xslt.xsl = File.open('path/to/xslfile.xsl', 'r').read
   #  xslt.xml = File.open('path/to/xmlfile.xml', 'r').read
    #render_text xslt.serve()

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @newsfeeds }
    end
  end
  def def_json()
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
    @newsfeed.save
    puts @newsfeeds
  end

  # GET /newsfeeds/new
  # GET /newsfeeds/new.json
  def new
    @newsfeeds = Newsfeed.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @newsfeeds }
    end
  end

  # GET /newsfeeds/1/edit
  def edit
    @newsfeeds = Newsfeed.find(params[:id])
  end
def follow()

end
  # POST /newsfeeds
  # POST /newsfeeds.json
  def create
    @newsfeeds = Newsfeed.new(params[:id])

    respond_to do |format|
      if @newsfeeds.save
        format.html { redirect_to @newsfeeds, notice: 'Newsfeed was successfully created.' }
        format.json { render json: @newsfeeds, status: :created, location: @newsfeeds }
      else
        format.html { render action: "new" }
        format.json { render json: @newsfeeds.errors, status: :unprocessable_entity }
      end
    end
  end
  # PUT /newsfeeds/1
  # PUT /newsfeeds/1.json
  def update
    @newsfeeds = Newsfeed.find(params[:id])

    respond_to do |format|
      if @newsfeeds.update_attributes(params[:links])
        format.html { redirect_to links, notice: 'Newsfeed was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @newsfeeds.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /newsfeeds/1
  # DELETE /newsfeeds/1.json
  def destroy
    @newsfeed = Newsfeed.find(params[:id])
    @newsfeed.destroy

    respond_to do |format|
      format.html { redirect_to newsfeeds_url }
      format.json { head :no_content }
    end
  end
  def create
    @newsfeed = current_user.newsfeed.build(newsfeed_params)
    if @newsfeed.save
      flash[:success] = "U r following this!"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  private

  def newsfeed_params
    params.require(:newsfeed).permit(:link)
  end
end