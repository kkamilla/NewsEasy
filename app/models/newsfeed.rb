class Newsfeed < ActiveRecord::Base
  attr_accessor :link, :title ,:description
  attr_accessible :link, :title ,:description
      def add(new_entry)
        case new_entry
          when Hash
            @newsfeeds.merge!(new_entry)
          when String
            @newsfeeds[new_entry] = nil

        end
      end
  def new()
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
  end
  end
