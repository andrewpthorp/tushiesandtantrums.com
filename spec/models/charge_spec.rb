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

end
