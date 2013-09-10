require 'spec_helper'

describe ChargesHelper do

  describe '#charge_status' do
    let(:charge) { FactoryGirl.create(:charge) }
    let(:results) { helper.charge_status(charge) }

    it 'should return an unordered list' do
      expect(results).to have_selector('ul.charge-statuses')
    end

    it 'should have the ordered status' do
      expect(results).to have_selector('span', text: 'Ordered:')
    end

    context 'when the charge has been shipped' do
      it 'should have the shipped status' do
        charge.update_column(:status, 'shipped')
        results = helper.charge_status(charge)
        expect(results).to have_selector('span', text: 'Shipped:')
      end
    end

    context 'when the charge has been completed' do
      it 'should have the completed status' do
        charge.update_column(:status, 'completed')
        results = helper.charge_status(charge)
        expect(results).to have_selector('span', text: 'Completed:')
      end
    end
  end

end
