# -*- coding: utf-8 -*-
require 'rss'
require 'open-uri'

def rss(params={})
  entries = []
  rss = RSS::Parser.parse(params[:url], false)
  rss.items.each do |item|
    entries << {title: item.title, date: item.date, link: item.link}
  end
  {title: rss.channel.title, entries: entries}
end
