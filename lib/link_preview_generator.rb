require 'net/http'
require 'nokogiri'

class LinkPreviewGenerator


  def self.get_preview_elements(url)
    link_elements = nil
    
    # generate a html get request to the link
    begin
      html_body = self.html_get_req(url) 
    rescue Exception => e
      puts "ERROR getting link preview : "+e.message
      return nil
    end 
    
    #parse the html body and retrieve the preiview elements
    if html_body != nil
      link_elements = self.get_html_elements(html_body) 
      return link_elements
    else
      return nil
    end 

  end

  def self.html_get_req(url)

    ishttps = false
    host = 80

    # if the link does not containt http or https then add
    if (/^https:\/\//.match(url)) 
      host = 443
      ishttps = true
    elsif (/^http:\/\//.match(url))
      # do nothing
    else
      url = "http://"+url
    end
    
    uri = URI.parse(url);
    http = Net::HTTP.new(uri.host, host)

    #if https link enable ssl
    if ishttps
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    end
    
    #Http request
    request = Net::HTTP::Get.new(uri.request_uri)   
    response = http.request(request)
    
    if response.code == "200"
      return response.body
    else
      return nil
    end 

  end

  def self.get_html_elements(html)
    elements = {}
    #parse the html 
    resp = Nokogiri::HTML(html)
    #fetch title
    elements[:title] = !(resp.css("meta [property='og:title']").empty?) ? resp.css("meta [property='og:title']")[0]["content"] : (!(resp.css("title").empty?) ? resp.css("title")[0].children[0].content : "" )

    #fetch description
    elements[:description] = !(resp.css("meta [property='og:description']").empty?) ? resp.css("meta [property='og:description']")[0]["content"] : ""

    #fetch image
    elements[:image_url] = !(resp.css("meta [property='og:image']").empty?) ? resp.css("meta [property='og:image']")[0]["content"] : ""

    #fetch type
    elements[:link_type] = !(resp.css("meta [property='og:type']").empty?) ? resp.css("meta [property='og:type']")[0]["content"] : ""

    #if type is video feth the video link
    elements[:video_url] = (elements[:link_type] == "video") ? resp.css("meta [property='og:url']")[0]["content"] : ""

    return elements
  end
end
  
