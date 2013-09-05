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
        @i = FactoryGirl.create(:inquiry)
      end

      it 'should run after create' do
        @i.should_receive(:send_email)
        @i.run_callbacks(:create)
      end

      it 'should send an email' do
        m = double('message')
        InquiryMailer.should_receive(:inquiry_email).with(@i).and_return(m)
        m.should_receive(:deliver)
        @i.send(:send_email)
      end
    end

  end

end
