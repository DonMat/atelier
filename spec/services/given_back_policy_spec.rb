require "rails_helper"

RSpec.describe GivenBackPolicy, type: :service do
  let(:user) { double }
  let(:book) { double }
  subject { described_class.new(user: user, book: book) }

  describe '#applies' do
    context 'can give back' do
      let(:reservation) { double }

      before {
        allow(subject).to receive_message_chain(:book, :reservations, :find_by).with(no_args).
          with(user: user, status: 'TAKEN').and_return(reservation)
      }

      it {
        expect(subject.applies?).to be_truthy
      }
    end

    context 'can\'t give back' do
      before {
        allow(subject).to receive_message_chain(:book, :reservations, :find_by).with(no_args).
          with(user: user, status: 'TAKEN').and_return(nil)
      }

      it {
        expect(subject.applies?).to be_falsy
      }
    end
  end
end
