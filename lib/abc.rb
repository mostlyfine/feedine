# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'time'

def abc(params={})
  url = 'http://www.aoyamabc.co.jp/event-date/'
  content =  Nokogiri::HTML(open(url).read)
  entries = []
  content.xpath("//div[@id='one_column']/div[@class='fourth box']/div").each do |event|
    date_str = event.xpath("div[@class='time']/p").text.to_s
    date = Time.parse(date_str.strip.tr("０-９","0-9").gsub(/[年月日]/,'/'))
    title = event.xpath("div[@class='title']/h3/a").text.to_s.strip
    link = event.xpath("div[@class='title']/h3/a").attribute('href').to_s.strip
    entries << {date: date, title: title, link: link, description: ""}
  end
  {title: '青山ブックセンター', url: url, entries: entries}
end
