xml.instruct! :xml, :version => '1.0', :encoding => 'UTF-8'
xml.kml(:xmlns => 'http:/earth.google.com/kml/2.2') do
  xml.Document do
    xml.name feed[:title]
    xml.Style(:id => 'highlight') do
      xml.IconStyle do
        xml.Icon do
          xml.href 'http://maps.google.com/mapfiles/ms/micons/blue-dot.png'
        end
      end
    end

    feed[:entries].each do |entry|
      xml.Placemark do
        xml.name entry[:title]
        xml.description do
          xml.cdata! entry[:description]
        end
      end
      xml.styleUrl '#highlight'
      xml.Point do
        xml.coordinates "#{entry[:lat]},#{entry[:lng]}"
      end
    end
  end
end
