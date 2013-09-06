require 'spec_helper'

describe Charge do

  describe '.associations' do
    it { should belong_to(:product) }
  end

  describe '.validations' do
    it { should validate_presence_of(:stripe_charge_id) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:product) }
    it { should validate_presence_of(:address_line_1) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }

    it { should validate_presence_of(:email) }
    it { should allow_value('andrewpthorp@gmail.com').for(:email) }
    it { should_not allow_value('andrewpthorp').for(:email) }
    it { should_not allow_value('andrewpthorp@').for(:email) }
    it { should_not allow_value('andrewpthorp@gmail').for(:email) }
    it { should_not allow_value('andrewpthorp@gmail.').for(:email) }
    it { should_not allow_value('@gmail.com').for(:email) }
  end

  describe '#methods' do
    before do
      @charge = FactoryGirl.create(:charge)
    end

    describe '#valid_without_stripe' do
      context 'with no errors' do
        it 'should return true' do
          expect(@charge.valid_without_stripe?).to be_true
        end
      end

      context 'with errors' do
        context 'and it is only one on :stripe_charge_id' do
          it 'should return false' do
            @charge.stripe_charge_id = nil
            expect(@charge.valid_without_stripe?).to be_true
          end
        end

        context 'and at least one of them is not :stripe_charge_id' do
          it 'should return true' do
            @charge.email = nil
            @charge.stripe_charge_id = nil
            expect(@charge.valid_without_stripe?).to be_false
          end
        end
      end
    end

    describe '#stripe' do
      before do
        @charge = FactoryGirl.create(:charge)
        @charge.stripe_charge_id = Stripe::Charge.create.id
      end

      it 'should fetch the object from Stripe' do
        Stripe::Charge.should_receive(:retrieve).with(@charge.stripe_charge_id)
        @charge.stripe
      end

      it 'should only fetch the object once' do
        @charge.stripe
        Stripe::Charge.should_not_receive(:retrieve)
        @charge.stripe
      end
    end
  end

end
