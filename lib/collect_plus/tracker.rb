require 'open-uri'
require 'nokogiri'

module CollectPlus
  class Tracker
    attr_accessor :tracking_no

    def initialize(tracking_no)
      @tracking_no = tracking_no
      track
    end

    # Retrieves the HTML page that contains tracking info, 
    # ready for parsing
    def track
      # Only need to extract the fragment of HTML that contains the tracking info
      @html_doc = Nokogiri::HTML(open("https://www.collectplus.co.uk/track/#{@tracking_no}")) { |config| config.nonet }.at_css("#left_pane")
    end

    def current_status
      # Parse the status info from the appropriate HTML element, if it exists
      # If not, parse the error message from the HTML and return it instead
      if status_node = @html_doc.at_css(".current_tracking_status")
        status_node.text.gsub(/\n/, " ").strip
      else
        @html_doc.at_css(".tracking_events").text.gsub(/\n/, " ").strip
      end
    end

    def status_history
      # Parse the list of statuses from the appropriate HTML element, if it exists
      # If not, parse the error message from the HTML and return it instead
      if status_list = @html_doc.css(".tracking_events > li")
        status_list.map do |status|
          status.css("span").map(&:text).join(" - ")
        end
      else
        @html_doc.at_css(".tracking_events").text.gsub(/\n/, " ").strip
      end
    end

    def status_summary
      summary = "CURRENT STATUS\n" << current_status << "\n\nSTATUS HISTORY\n"
      summary << status_history.join("\n\n")
    end
  end
end
