RSpec.describe PostsController, type: :controller do
  describe 'POST create' do
    context 'with valid params' do
      let(:valid_params) do
        {
          login: Faker::Artist.name,
          title: Faker::BackToTheFuture.character,
          body: Faker::HarryPotter.quote,
          author_ip: Faker::Internet.ip_v4_address
        }
      end
      before do
        post :create, params: valid_params
      end

      it 'should return 200' do
        expect(response).to be_successful
      end

      it 'should return post with valid params' do
        res = JSON.parse(response.body)
        expect(res[:title]).to eq(valid_params['title'])
        expect(res[:body]).to eq(valid_params['body'])
        expect(res[:author_ip]).to eq(valid_params['author_ip'])
      end

      it 'creates author unless it persists' do
        login = Faker::HarryPotter.character
        author = Author.find_by(login: login)
        expect(author).to be_nil
        new_valid_params = valid_params.merge(login: login)
        expect { post :create, params: new_valid_params }.to change(Author, :count).by(1)
      end
    end

    context 'with invalid params' do
      it 'should return 422 without params' do
        post :create, params: { title: nil, body: nil, author_ip: nil, login: nil }
        expect(response.status).to eq(422)
      end
    end
  end

  describe 'GET /best_posts/:rating(/length)' do

    context 'with valid params' do
      before do
        sample_arr = *(1..5).map(&:to_f)
        @posts = []

        100.times do
          post = FactoryBot.create(:post_with_ratings, average_rating: sample_arr.sample)
          ensure
          @posts << post
          end
      end

      it 'should respond with 200' do
        get :best_posts, params: { length: 3}
        expect(response).to be_successful
      end

      it 'should respond with a give length' do
        get :best_posts, params: { length: 3}
        expect(JSON.parse(response.body)).to_not be_empty
        expect(JSON.parse(response.body).size).to eq(3)
      end

      it 'should respond with 422 if no length given' do
        get :best_posts, params: {length: ''}
        expect(response).to_not be_successful
        expect(response.status).to eq(422)
        expect(response.message).to eq('Unprocessable Entity')
      end
    end
  end
end
