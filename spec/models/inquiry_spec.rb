require 'spec_helper'

describe Inquiry do

  describe '.validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:subject) }
    it { should validate_presence_of(:body) }
  end

  describe '.callbacks' do

    describe '.send_email' do
      before do
        @inquiry = FactoryGirl.create(:inquiry)
      end

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

end
