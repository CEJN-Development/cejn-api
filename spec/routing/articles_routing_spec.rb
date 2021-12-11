require "rails_helper"

RSpec.describe ArticlesController, type: :routing do
  describe "routing" do
    let(:slug) { "article_slug" }

    it "routes to #index" do
      expect(get: "/articles").to route_to("articles#index")
    end

    it "routes to #show" do
      expect(get: "/articles/#{slug}").to route_to("articles#show", slug: slug)
    end

    it "routes to #create" do
      expect(post: "/articles").to route_to("articles#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/articles/#{slug}").to route_to("articles#update", slug: slug)
    end

    it "routes to #update via PATCH" do
      expect(patch: "/articles/#{slug}").to route_to("articles#update", slug: slug)
    end

    it "routes to #destroy" do
      expect(delete: "/articles/#{slug}").to route_to("articles#destroy", slug: slug)
    end
  end
end
