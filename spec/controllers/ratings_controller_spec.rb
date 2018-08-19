RSpec.describe RatingsController, type: :controller do

  describe 'POST /create' do

    before(:context) do
      @post = FactoryBot.create(:post)
    end

    context 'with valid params' do
      before(:each) do
        post :create, params: {post_id: @post.id, mark: 4}
      end

      it 'returns status code 200' do
        expect(response).to be_success
      end

      xit 'should return new average' do
        res = JSON.parse(response.body)
      end

    end

    context 'with invalid params' do
      before(:each) do
        post :create, params: {post_id: @post.id, mark: nil}
      end

      it 'returns status code 422' do
        expect(response.status).to eq(422)
      end
    end
  end
end