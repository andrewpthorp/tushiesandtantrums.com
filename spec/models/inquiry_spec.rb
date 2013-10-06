require 'spec_helper'

describe Inquiry do

  describe '.validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }

    it { should allow_value('unread').for(:status) }
    it { should allow_value('read').for(:status) }
    it { should_not allow_value('foobar').for(:status) }
  end

  describe '.callbacks' do
    before do
      @inquiry = FactoryGirl.create(:inquiry)
    end

    describe '.set_default_status' do
      it 'should run the callback before validation' do
        @inquiry.should_receive(:set_default_status)
        @inquiry.run_callbacks(:validation)
      end

      it 'should set the status if it is blank' do
        @inquiry.status = ''
        @inquiry.send(:set_default_status)
        expect(@inquiry.status).to eq('unread')
      end

      it 'should not change the status if it is not blank' do
        @inquiry.status = 'read'
        @inquiry.send(:set_default_status)
        expect(@inquiry.status).to eq('read')
      end
    end

    describe '.send_email' do
      it 'should run after create' do
        @inquiry.should_receive(:send_email)
        @inquiry.run_callbacks(:create)
      end

      it 'should send an email' do
        m = double('message')
        InquiryMailer.should_receive(:inquiry_created_email).with(@inquiry)
          .and_return(m)
        m.should_receive(:deliver)
        @inquiry.send(:send_email)
      end
    end
  end

  describe '#methods' do
    before do
      @inquiry = FactoryGirl.create(:inquiry)
    end

    describe 'unread?' do
      context 'when the status is unread' do
        it 'should be true' do
          @inquiry.status = 'unread'
          expect(@inquiry).to be_unread
        end
      end

      context 'when the status is not unread' do
        it 'should be false' do
          @inquiry.status = 'read'
          expect(@inquiry).not_to be_unread
        end
      end
    end

    describe 'read?' do
      context 'when the status is read' do
        it 'should be true' do
          @inquiry.status = 'read'
          expect(@inquiry).to be_read
        end
      end

      context 'when the status is not read' do
        it 'should be false' do
          @inquiry.status = 'unread'
          expect(@inquiry).not_to be_read
        end
      end
    end
  end

end
