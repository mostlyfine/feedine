# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'
require 'time'

def eplus(params={})
  url = "http://eplus.jp/sys/web/flist-pc/00_pre_now.jsp?siteCode=#{params[:code] || '0137'}&selectedArea=#{params[:area] || '05'}&selectedGenre=300&selectedDispFlg=1"
  entries = []
  content =  Nokogiri::HTML(open(url).read)
  content.xpath("//div[@class='title-result']/table/tr").each do |event|
    link_tag = event.xpath("td/table/tr/td[2]/div[@class='performName']/strong/a")
    title = link_tag.text.to_s.strip
    link = link_tag.attribute('href').to_s
    desc = event.xpath("td/table/tr/td[2]/div[@class='statement']").text.to_s.strip
    times = /[0-9]+\/[0-9]+\/[0-9]+/.match(event.xpath("td[@class='sortDate']/span").text.to_s.strip).to_a
    date = Time.parse(times[0])
    entries << {title: title, link: link, description: desc, date:date}
  end
  {title: 'e+', url: url, entries: entries}
end
