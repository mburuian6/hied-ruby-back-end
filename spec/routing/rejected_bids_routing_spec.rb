require "rails_helper"

RSpec.describe RejectedBidsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/rejected_bids").to route_to("rejected_bids#index")
    end

    it "routes to #show" do
      expect(get: "/rejected_bids/1").to route_to("rejected_bids#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/rejected_bids").to route_to("rejected_bids#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/rejected_bids/1").to route_to("rejected_bids#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/rejected_bids/1").to route_to("rejected_bids#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/rejected_bids/1").to route_to("rejected_bids#destroy", id: "1")
    end
  end
end
