RSpec.describe PostValidator, type: :model do
  context 'validation' do
    it 'should pass with valida params' do
      validator = PostValidator.new(FactoryBot.build(:post))
      expect(validator).to be_valid
    end

    it 'should fail with invalid params' do
      validator = PostValidator.new(FactoryBot.build(:empty_post))
      expect(validator).to_not be_valid
      expect(validator.errors.messages).to include(
        title: [%(can't be blank)],
        body: [%(can't be blank)],
        author_ip: [%(can't be blank)],
        author: [%(can't be blank)]
      )
    end
  end
end
