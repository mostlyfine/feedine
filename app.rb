# -*- coding: utf-8 -*-
require 'sinatra'
require 'haml'
require 'json'
require 'builder'
require 'sinatra/static_assets'

configure do
  set :haml, :escape_html => false, :format => :html5
  Dir.glob('lib/**/*.rb').sort.each{|f| load f }
end

before do
  content_type 'text/html', :charset => 'utf-8'
end

helpers do
  def atom_at(time=Time.now)
    time.strftime('%Y-%m-%dT%H:%M:%SZ')
  end

  def ical_at(time=Time.now)
    time.strftime(time.hour + time.min == 0 ? '%Y%m%d' : '%Y%m%d%H%M')
  end

  def turned(msg)
    msg ? msg.gsub(/(。|！|」|』)/,'\1<br/>') : msg
  end

  def ics(entry)
    content_type 'text/calendar', :charset => 'utf-8'
    haml :ical, :layout => false, :locals => {feed: entry}
  end

  def kml(entry)
    content_type 'application/vnd.google-earth.kml+xml', :charset => 'utf-8'
    builder :kml, :locals => {feed: entry}
  end

  def atom(entry)
    content_type 'application/atom+xml', :charset => 'utf-8'
    builder :atom, :locals => {feed: entry}
  end

  def json(entry)
    content_type :json, :charset => 'utf-8'
    JSON.unparse entry
  end

  def html(entry)
    haml :show, :locals => {feed: entry}
  end
end


get '/' do
  haml :index
end

get '/:name.:type' do |name, type|
  send(type, send(name))
end
