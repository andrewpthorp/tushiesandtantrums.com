require 'spec_helper'

describe Post do

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '.scopes' do
    describe '.published' do
      it 'should return published records from the database' do
        FactoryGirl.create(:post)
        FactoryGirl.create(:draft)
        expect(Post.published.size).to eq(1)
      end
    end
  end

  describe '.friendly_id' do
    it 'should set a slug' do
      post = FactoryGirl.create(:post)
      post.slug.should_not be_nil
    end
  end

end
