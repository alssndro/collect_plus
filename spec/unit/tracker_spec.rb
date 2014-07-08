require 'spec_helper'

describe CollectPlus::Tracker do
  context "when the tracking number exists" do
    before(:each) do      
    # Stub net requests with HTML files in spec's support directory
      WebMock.stub_request(:get, "https://www.collectplus.co.uk/track/SE12345").
        to_return(:status => 200, :body => File.new("spec/support/parcel_status.html"), :headers => {})
      end

    let(:tracker) { CollectPlus::Tracker.new("SE12345") }

    it "can return the current status of the parcel" do
      expect(tracker.current_status).to eq("Despatched from SOME LONDON DEPOT at 15:58, Mon, 07 Jul 2014")
    end

    it "can return previous statuses" do
      status_history = tracker.status_history
      expect(status_history).to eq(["Parcel collected - 11:46, Mon, 07 Jul 2014",
                                    "Received at SPAR, ABC 123 - 08:21, Mon, 07 Jul 2014",
                                    "Delivery booked - 20:06, Sun, 06 Jul 2014"])
    end

    it "can return a summary of the delivery status" do
      expect(tracker.status_summary).to eq("CURRENT STATUS\nDespatched from SOME LONDON DEPOT at 15:58, Mon, 07 Jul 2014\n\nSTATUS HISTORY\nParcel collected - 11:46, Mon, 07 Jul 2014\n\nReceived at SPAR, ABC 123 - 08:21, Mon, 07 Jul 2014\n\nDelivery booked - 20:06, Sun, 06 Jul 2014")
    end
  end

  context "when the tracking number does not exists" do
    before(:all) do      
      # Stub net requests with HTML files in spec's support directory
      WebMock.stub_request(:get, "https://www.collectplus.co.uk/track/NOTATRACKINGNUMBER").
        to_return(:status => 200, :body => File.new("spec/support/parcel_doesnt_exist.html"), :headers => {})
    end

    let(:tracker) { CollectPlus::Tracker.new("NOTATRACKINGNUMBER") }

    it "notifies that parcel info cannot be found" do
      expect(tracker.current_status).to eq("Sorry, the tracking code NOTATRACKINGNUMBER could not be found. Please check your CollectPlus receipt for a 7-character tracking code.")
    end
  end
end
