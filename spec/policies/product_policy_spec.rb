# frozen_string_literal: true

require "rails_helper"

RSpec.describe ProductPolicy, type: :policy do
  subject { described_class }
  let(:admin_user) { create(:user, role: :admin) }

  permissions :fetch_products? do
    context "allow" do
      context "when admin user" do
        it { expect(subject).to permit(admin_user, Product.new) }
      end
    end
  end
end
