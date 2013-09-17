require 'spec_helper'

describe Charge do

  describe '.mass-assignment' do
    it { should allow_mass_assignment_of(:stripe_charge_id) }
    it { should allow_mass_assignment_of(:email) }
    it { should allow_mass_assignment_of(:name) }
    it { should allow_mass_assignment_of(:product_id) }
    it { should allow_mass_assignment_of(:status) }
    it { should allow_mass_assignment_of(:address_line_1) }
    it { should allow_mass_assignment_of(:address_line_2) }
    it { should allow_mass_assignment_of(:city) }
    it { should allow_mass_assignment_of(:state) }
    it { should allow_mass_assignment_of(:zip) }
  end

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

    it { should allow_value('ordered').for(:status) }
    it { should allow_value('shipped').for(:status) }
    it { should allow_value('completed').for(:status) }
    it { should_not allow_value('foobar').for(:status) }
  end

  describe '.callbacks' do
    before do
      @charge = FactoryGirl.build(:charge)
    end

    describe '.set_default_status' do
      it 'should run the callback before validation' do
        @charge.should_receive(:set_default_status)
        @charge.run_callbacks(:validation)
      end

      it 'should set the status if it is blank' do
        @charge.status = ''
        @charge.send(:set_default_status)
        expect(@charge.status).to eq('ordered')
      end

      it 'should not change the status if it is not blank' do
        @charge.status = 'shipped'
        @charge.send(:set_default_status)
        expect(@charge.status).to eq('shipped')
      end
    end

    describe '.send_email' do
      it 'should run the callback after create' do
        @charge.should_receive(:send_email)
        @charge.run_callbacks(:create)
      end

      it 'should send an email' do
        m = double('message')
        ChargeMailer.should_receive(:charge_created_email).with(@charge)
          .and_return(m)
        m.should_receive(:deliver)
        @charge.send(:send_email)
      end
    end
  end

  describe '.scopes' do
    before do
      @charge = FactoryGirl.create(:charge, status: 'ordered')
    end

    describe '.by_date' do
      it 'should order charges correctly' do
        expect(Charge.by_date.to_sql).to match(/ORDER BY created_at ASC/)
      end
    end

    describe '.ordered' do
      it 'should return the correct charges' do
        expect(Charge.ordered).to eq([@charge])
      end
    end

    describe '.shipped' do
      it 'should return the correct charges' do
        @charge.update_attributes(status: 'shipped')
        expect(Charge.shipped).to eq([@charge])
      end
    end

    describe '.completed' do
      it 'should return the correct charges' do
        @charge.update_attributes(status: 'completed')
        expect(Charge.completed).to eq([@charge])
      end
    end
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

    describe '#ordered?' do
      context 'when the status is ordered' do
        it 'should be true' do
          @charge.status = 'ordered'
          expect(@charge).to be_ordered
        end
      end

      context 'when the status is not ordered' do
        it 'should be false' do
          @charge.status = 'shipped'
          expect(@charge).not_to be_ordered
        end
      end
    end

    describe '#shipped?' do
      context 'when the status is shipped' do
        it 'should be true' do
          @charge.status = 'shipped'
          expect(@charge).to be_shipped
        end
      end

      context 'when the status is not shipped' do
        it 'should be false' do
          @charge.status = 'ordered'
          expect(@charge).not_to be_shipped
        end
      end
    end

    describe '#completed?' do
      context 'when the status is completed' do
        it 'should be true' do
          @charge.status = 'completed'
          expect(@charge).to be_completed
        end
      end

      context 'when the status is not completed' do
        it 'should be false' do
          @charge.status = 'shipped'
          expect(@charge).not_to be_completed
        end
      end
    end
  end

end
