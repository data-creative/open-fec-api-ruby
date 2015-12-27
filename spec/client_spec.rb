require 'spec_helper'

module OpenFecApi
  RSpec.describe Client do

    #
    # Candidates Endpoint
    #

    describe '#candidates' do
      context 'when configured' do
        before do
          @client = OpenFecApi::Client.new(ENV["OPEN_FEC_API_KEY"])
        end

        def request_and_print(options)
          response = @client.candidates(options)
          pp response.summary
          return response
        end

        it "is configured" do
          expect(@client.configured?)
        end

        it "returns responses" do
          response = @client.candidates
          expect(response).to be_kind_of(OpenFecApi::Response)
        end

        it "accepts pagination options and avoids rate limits" do
          options = {:page => 1, :per_page => 100}
          response = request_and_print(options)
          expect(response.results_count).to eql(100)
          while response.page < response.pages && response.page < 5 do
            options.merge!({:page => response.page + 1})
            response = request_and_print(options)
          end
          success = true
          expect(success)
        end

        it "accepts endpoint-specific options" do
          options = {:party => "DEM"}
          response = request_and_print(options)
          expect(response.results.map{|c| c["party"]}.uniq).to eql(["DEM"])
        end #todo: maybe return mock response instead

        it "prevents unrecognized params from being requested" do
          unrecognized_params = {:hair_color => "brown"}
          response = request_and_print(unrecognized_params)
          recognized_params = response.request_query
          expect(!recognized_params.keys.include?("hair_color"))
        end
      end
    end

    #
    # Candidate Endpoint
    #

    describe '#candidate' do
      context "when configured" do
        let(:candidate_id){"P00003392"}
        before do
          @client = OpenFecApi::Client.new(ENV["OPEN_FEC_API_KEY"])
        end

        def request_and_print(candidate_id, options)
          response = @client.candidate(candidate_id, options)
          pp response.summary
          return response
        end #todo: maybe return mock response instead

        it "returns data about the specified candidate" do
          options = {:page => 1, :per_page => 100}
          response = request_and_print(candidate_id, options)
          candidate_name = response.results.map{|c| c["name"]}.uniq
          expect(candidate_name).to eql(["CLINTON, HILLARY RODHAM"])
        end
      end
    end



















    #
    # Committees Endpoint
    #

    describe '#committees' do
      context 'when configured' do
        let(:committee_id){"C00563023"}

        before do
          @client = OpenFecApi::Client.new(ENV["OPEN_FEC_API_KEY"])
        end

        def request_and_print(options)
          response = @client.committees(options)
          pp response.summary
          return response
        end #todo: maybe return mock response instead

        it "accepts accepts endpoint-specific options like Committee ID" do
          options = {:committee_id => committee_id}
          response = request_and_print(options)
          committe_treasurer_name = response.results.map{|c| c["treasurer_name"]}.uniq
          expect(committe_treasurer_name).to eql(["RANDI M WILLIS"])
        end
      end
    end



    #
    # Committee Endpoint
    #

    describe '#committee' do
      context "when configured" do
        let(:committee_id){"C00571372"}
        before do
          @client = OpenFecApi::Client.new(ENV["OPEN_FEC_API_KEY"])
        end

        def request_and_print(committee_id, options)
          response = @client.committee(committee_id, options)
          pp response.summary
          return response
        end #todo: maybe return mock response instead

        it "returns data about the specified committee" do
          options = {:page => 1, :per_page => 100}
          response = request_and_print(committee_id, options)
          committee_name = response.results.map{|c| c["name"]}.uniq
          expect(committee_name).to eql(["RIGHT TO RISE USA"])
        end
      end
    end

  end
end
