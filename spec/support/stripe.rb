# frozen_string_literal: true

RSpec.configure do |config|
  config.before do
    allow(Stripe::Customer).to receive(:create).and_return(
      double('Stripe::Customer', id: 'cus_test123')
    )
  end
end
