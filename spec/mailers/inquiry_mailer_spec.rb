require "spec_helper"

describe InquiryMailer do

  describe '.inquiry_created_email' do
    before do
      @inquiry = FactoryGirl.create(:inquiry)
      @mail = InquiryMailer.inquiry_created_email(@inquiry)
    end

    it 'should render the subject' do
      @mail.subject.should eq('New Message from your Website')
    end

    it 'should send the email to the right person' do
      @mail.to.should eq(['tushiesandtantrums@gmail.com'])
    end

    it 'should set the sender to the right email' do
      @mail.from.should eq(['no-reply@tushiesandtantrums.com'])
    end

    it 'should set the reply-to to the right email' do
      @mail.reply_to.should eq([@inquiry.email])
    end

    it 'should assign @inquiry' do
      @mail.body.encoded.should match(@inquiry.body)
    end

  end

end
