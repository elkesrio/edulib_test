require 'rails_helper'

RSpec.describe "Repositories", type: :request do
  describe "GET /index" do
    let(:subject) { get '/repositories/'}

    it "calls Repositories::FetchOrList" do
      expect_any_instance_of(Repositories::FetchOrList).to receive(:call).and_return [Repository.create!(url: 'http://example.com/toto')]

      subject
    end
  end

  describe "GET /show" do
    let(:subject) { get "/repositories/#{id}"}
    
    context "when the repository exists" do
      let(:id) { Repository.create!(url: "http://example.com/toto").id }

      it "displays the name" do
        subject
        expect(response.body).to include 'toto'
      end
    end

    context "when the repository does not exist" do
      let(:id) { "not_found" }

      it "redirects to index" do
        subject
        expect(response).to redirect_to "/repositories"
      end
    end
  end
end
