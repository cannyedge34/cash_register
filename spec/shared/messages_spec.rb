# frozen_string_literal: true

require 'shared/messages'

describe Shared::Messages do
  before { allow(described_class).to receive(:print) }

  describe '.print' do
    it 'prints the error message' do
      described_class.print('message')

      expect(described_class).to have_received(:print).with('message')
    end
  end
end
