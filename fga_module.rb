require 'cgi'
require 'json'
require 'open-uri'

ANC = "https://graph.facebook.com/"
TOK = "&access_token=<insert your access token>"
FBID = '<insert your facebook username or id>'

module FgaModule
  def self.custom_open app, query
    inp = query.map do |k, v|
            "#{ k }=#{ v }"
          end.join "&"
    open(URI.encode( ANC + app + inp + TOK )) do |ajos|
      ajlo = JSON.parse(ajos.read)
    end
  end
  def self.search_events word
    custom_open "search?type=event&", "q" => word
  end
  def self.search_groups word
    custom_open "search?type=group&", "q" => word
  end
  def self.search_profilefeed word
    custom_open "#{FBID}/feed?", "q" => word
  end
  def self.search_newsfeed word
    custom_open "#{FBID}/home?", "q" => word
  end
  def self.add_event name, description, location, start_time, end_time
    custom_open "#{FBID}/events?method=post&", "name" => name, "description" => description, "location" => location, "start_time" => start_time, "end_time" => end_time
  end
  def self.add_statusupdate message
    custom_open "#{FBID}/feed?method=post&", "message" => message
  end
end
