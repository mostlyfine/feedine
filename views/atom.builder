xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.feed(:xmlns => 'http://www.w3.org/2005/Atom') do
  xml.id request.url
  xml.title feed[:title]
  xml.updated atom_at
  xml.link(:rel => 'alternate', :href => request.url)

  xml.author do
    xml.name feed[:title]
    xml.uri request.url
  end

  feed[:entries].each_with_index do |entry, index|
    xml.entry do
      xml.id index
      xml.title entry[:title]
      xml.issued atom_at(entry[:date])
      xml.link(:rel => 'alternate', :href => entry[:link])
      if entry[:description]
        xml.content(:type => 'html') do |s|
          s.cdata! turned(entry[:description])
        end
      end
    end
  end
end

