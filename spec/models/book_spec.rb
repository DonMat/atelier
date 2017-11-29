require "rails_helper"

RSpec.describe Book, type: :model do
  subject { described_class.new }
  let(:user) { User.new }

  describe '#can_reserve?' do
    context 'with reservations' do
      let(:reservation) { double }

      before {
        allow(subject).to receive_message_chain(:reservations, :find_by).with(no_args).
          with(user: user, status: 'RESERVED').and_return(reservation)
      }

      it {
        expect(subject.can_reserve?(user)).to be_falsey
      }
    end

    context 'without any reservations' do
      let(:reservation) { double }

      before {
        allow(subject).to receive_message_chain(:reservations, :find_by).with(no_args).
          with(user: user, status: 'RESERVED').and_return(nil)
      }

      it {
        expect(subject.can_reserve?(user)).to be_truthy
      }
    end
  end
end
