# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

def abc
  url = 'http://www.aoyamabc.co.jp/event-date/'
  content =  Nokogiri::HTML(open(url).read)
  entries = []
  content.xpath("//div[@id='one_column']/div[@class='fourth box']/div").each do |event|
    time = time_parse event.xpath("div[@class='time']/p").text
    title = event.xpath("div[@class='title']/h3/a").text.to_s.strip
    link = event.xpath("div[@class='title']/h3/a").attribute('href').to_s.strip
    entries << {date: time, title: title, link: link, description: ""}
  end
  feed = {title: '青山ブックセンター', url: url, entries: entries}
end

def time_parse(date)
  times = /([0-9]+)年([0-9]+)月([0-9]+)日/.match(date.to_s.strip.tr("０-９","0-9")).to_a
  times.delete_at(0)
  Time.local(*times)
end

puts abc[:title]
