require "rails_helper"

RSpec.describe BiosController, type: :routing do
  describe "routing" do
    let(:slug) { "bio_slug" }

    it "routes to #index" do
      expect(get: "/bios").to route_to("bios#index")
    end

    it "routes to #show" do
      expect(get: "/bios/#{slug}").to route_to("bios#show", slug: slug)
    end

    it "routes to #create" do
      expect(post: "/bios").to route_to("bios#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/bios/#{slug}").to route_to("bios#update", slug: slug)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/bios/#{slug}").to route_to("bios#update", slug: slug)
    end

    it "routes to #destroy" do
      expect(delete: "/bios/#{slug}").to route_to("bios#destroy", slug: slug)
    end
  end
end
