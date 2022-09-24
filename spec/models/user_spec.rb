require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
    let(:user) { User.create(email: 'email@gmail.com', password: 'password') }

    it 'NOT enable me to create user without name' do
      expect(User.count).to eq(0)
      expect(user.valid?).to eq(false)
    end
  end

  describe 'enum' do
    it 'enable mee to see user roles' do
      expect(User.roles.keys).to eq(%w[customer admin])
    end
  end

  describe "db fields" do
    it { should have_db_column(:name).of_type(:string) }
    it { is_expected.to have_many(:products) }
  end
end
