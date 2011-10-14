# -*- coding: utf-8 -*-
require 'nokogiri'
require 'open-uri'

def plusone
  url = 'http://www.loft-prj.co.jp/PLUSONE/schedule/lpo.cgi'
  content =  Nokogiri::HTML(open(url,'r:Windows-31J').read)
  entries = []
  content.xpath("//body/center/center/center/table/tr/td/table/tr").each do |event|
    title = event.xpath("td[2]/p[@class='content']/font[1]/b").text.to_s.strip
    desc = event.xpath("td[2]").text.to_s.strip
    time = /START ([0-9]+):([0-9]+)/.match(desc).to_a
    t = Time.now
    day = /([0-9]*)/.match(event.xpath("td[1]").text.strip).to_a[1]
    hour = time[1].to_i > 23 ? 0 : time[1]
    min = time[2].to_i
    date = Time.mktime(t.year, t.month, day, hour, min)
    entries << {title: title, description: desc, date: date}
  end
  feed = {title: 'ロフトプラスワン', url: url, entries: entries}
end
