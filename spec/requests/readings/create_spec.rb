require 'rails_helper'

RSpec.describe "Readings", type: :request do
  describe "POST /readings" do

    subject(:readings_request) { post api_v1_readings_url, params: params, as: :json }
    
    context "when payload params are valid" do
      let(:params) do 
        {
          id: "36d5658a-6908-479e-887e-a949ec199272",
          readings: [
              {
                  timestamp: "2021-09-29T16:08:15+01:00",
                  count: 4
              },
              {
                  timestamp: "YUDS-09-29T16:09:15+01:00",
                  count: 15
              }
          ]
        }
      end

      before do
        subject
      end

      it "returns a sucessful response" do
        expect(response).to be_successful
      end
    end

    context "when payload params are incomplete" do
      let(:params) do 
        {
          id: "36d5658a-6908-479e-887e-a949ec199272"
        }
      end

      before do
        subject
      end

      it "returns an error message" do
        expect(response.body).to include 'Invalid payload params'
        expect(response).to_not be_successful
      end
    end

    context "when recordings params is malformed" do
      let(:params) do 
        {
          id: "36d5658a-6908-479e-887e-a949ec199272",
          readings: [
              {
                  timestamp: "2022-40-40T16:09:15+01:00",
                  count: 4
              }
          ]
        }
      end

      before do
        subject
      end

      it "returns an error message" do
        expect(response.body).to include 'Invalid readings'
        expect(response).to_not be_successful
      end
    end
  end
end
