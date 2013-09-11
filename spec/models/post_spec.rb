require 'spec_helper'

describe Post do

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '.scopes' do
    let(:draft) { FactoryGirl.create(:draft) }
    let(:post) { FactoryGirl.create(:post) }

    describe '.published' do
      it 'should return published records from the database' do
        expect(Post.published).to eq([post])
      end
    end

    describe '.drafted' do
      it 'should return records that are not published from the database' do
        expect(Post.drafted).to eq([draft])
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
