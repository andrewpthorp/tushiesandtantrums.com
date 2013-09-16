require "spec_helper"

describe ChargeMailer do

  describe '.charge_created_email' do
    before do
      @charge = FactoryGirl.create(:charge)
      @mail = ChargeMailer.charge_created_email(@charge)
    end

    it 'should render the subject' do
      expect(@mail.subject).to eq('New Order placed on your Website!')
    end

    it 'should send the email to the right person' do
      expect(@mail.to).to eq(['tushiesandtantrums@gmail.com'])
    end

    it 'should set the sender to the right email' do
      expect(@mail.from).to eq(['no-reply@tushiesandtantrums.com'])
    end

    it 'should assign @charge' do
      expect(@mail.body.encoded).to match(@charge.name)
    end
  end

end
