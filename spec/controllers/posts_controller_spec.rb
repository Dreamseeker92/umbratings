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
        expect(response).to be_success
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
        10.times do
         post = FactoryBot.create(:post, average_rating: sample_arr.sample)
        ensure
          @posts << post
        end
      end

      it 'should return oly posts for a given rating' do
        average_for_two = @posts.select {|p| p.average_rating == 2.0 }
        get :best_posts, params: { rating: 2 }
        expect(JSON.parse(response.body).size).to eq(average_for_two.count)
        expect(JSON.parse(response.body)).to eq(average_for_two.pluck(:title, :body))
      end

      it 'should respond with 200' do
        post :best_posts, params: { rating: 3}
        expect(response).to be_success
      end
    end
  end
end
