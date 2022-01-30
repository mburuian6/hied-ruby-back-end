require "rails_helper"

RSpec.describe AcceptedBidsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/accepted_bids").to route_to("accepted_bids#index")
    end

    it "routes to #show" do
      expect(get: "/accepted_bids/1").to route_to("accepted_bids#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/accepted_bids").to route_to("accepted_bids#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/accepted_bids/1").to route_to("accepted_bids#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/accepted_bids/1").to route_to("accepted_bids#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/accepted_bids/1").to route_to("accepted_bids#destroy", id: "1")
    end
  end
end
