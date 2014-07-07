require 'spec_helper'

describe CollectPlus::Tracker do
  context "when the tracking number exists" do
    let(:tracker) { CollectPlus::Tracker.new("SE12345") }

    it "returns the status of the parcel" do
      expect(tracker.status).to eq("Despatched from SOME LONDON DEPOT at 15:58, Mon, 07 Jul 2014")
    end  
  end

  context "when the tracking number does not exists" do
    let(:tracker) { CollectPlus::Tracker.new("NOTATRACKINGNUMBER") }

    it "returns the status of the parcel" do
      expect(tracker.status).to eq("Sorry, the tracking code NOTATRACKINGNUMBER could not be found. Please check your CollectPlus receipt for a 7-character tracking code.")
    end 
  end
end
