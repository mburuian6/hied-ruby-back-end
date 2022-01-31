require "rails_helper"

RSpec.describe PostLinksController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/post_links").to route_to("post_links#index")
    end

    it "routes to #show" do
      expect(get: "/post_links/1").to route_to("post_links#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/post_links").to route_to("post_links#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/post_links/1").to route_to("post_links#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/post_links/1").to route_to("post_links#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/post_links/1").to route_to("post_links#destroy", id: "1")
    end
  end
end
