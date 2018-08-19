RSpec.describe Post, type: :model do
  it { should have_many(:ratings) }
  it { should belong_to(:author) }
end
