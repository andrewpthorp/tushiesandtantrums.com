require "spec_helper"

describe InquiryMailer do

  describe '.inquiry_email' do
    before do
      @inquiry = FactoryGirl.create(:inquiry)
      @mail = InquiryMailer.inquiry_email(@inquiry)
    end

    it 'should render the subject' do
      @mail.subject.should eq('New Message from your Website')
    end

    it 'should send the email to the right person' do
      @mail.to.should eq(['tushiesandtantrums@gmail.com'])
    end

    it 'should set the sender to the right email' do
      @mail.from.should eq(['tushiesandtantrums+website@gmail.com'])
    end

    it 'should assign @inquiry' do
      @mail.body.encoded.should match(@inquiry.body)
    end

  end

end
