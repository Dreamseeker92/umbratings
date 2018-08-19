require 'rails_helper'

RSpec.describe IpController, type: :controller do

  describe 'GET /ip_list' do
    before do
      @ip_1 = Faker::Internet.ip_v4_address
      @ip_1_login_arr = []
      @ip_2_login_arr = []
      @ip_2 = Faker::Internet.ip_v4_address
      @ip_3 = Faker::Internet.ip_v4_address
      5.times do
        authors = FactoryBot.create_list(:author, 20)
        post_1 = FactoryBot.create(:post, author_ip: @ip_1, author: authors.sample)
        @ip_1_login_arr << post_1.author_login
        post_2 = FactoryBot.create(:post, author_ip: @ip_2, author: authors.sample)
        @ip_2_login_arr << post_2.author_login

      end
      get :ip_list
    end

    it 'should return ips' do
      res = JSON.parse(response.body)
      expect(res.count).to eq(2)

      first_ip_list = res.detect { |r| r['author_ip'] == @ip_1 }
      second_ip_list = res.detect { |r| r['author_ip'] == @ip_2 }
      expect([first_ip_list, second_ip_list]).to all( be_truthy )

      third_ip_list = res.detect { |r| r['author_ip'] == @ip_3 }
      expect(third_ip_list).to be_nil
      expect(first_ip_list['array_agg'].sort).to eq(@ip_1_login_arr.sort)
      expect(second_ip_list['array_agg'].sort).to eq(@ip_2_login_arr.sort)
    end

    it 'should return 200' do
      expect(response).to be_success
    end
  end

end
