require 'spec_helper'

describe Post do

  describe '.validations' do
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:body) }
  end

  describe '.friendly_id' do
    it 'should set a slug' do
      post = FactoryGirl.create(:post)
      post.slug.should_not be_nil
    end
  end

  describe '.pagination' do
    it 'should default to 5 records per page' do
      expect(Post.default_per_page).to eq(5)
    end
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

    describe '.ordered' do
      it 'should order results correctly' do
        expect(Post.ordered.to_sql).to match(/ORDER BY created_at DESC/)
      end
    end

    describe '.exclude' do
      it 'should not include a post with the given id' do
        expect(Post.exclude(draft.id)).to eq([post])
      end
    end

    describe '.latest' do
      it 'should only get the latest post' do
        draft.update_column(:created_at, 2.days.ago)
        post.update_column(:created_at, 1.day.ago)
        expect(Post.latest).to eq(post)
      end
    end
  end

end
