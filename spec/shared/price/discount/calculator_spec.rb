# frozen_string_literal: true

require './lib/shared/price/discount/calculators_data'
require './lib/shared/price/discount/calculator'
require './lib/items/domain/entity'
require './lib/promotions/domain/entity'
require './lib/pricing_rules/domain/entity'
require './lib/shared/price/discount/calculators/bulk_purchase'

describe Shared::Price::Discount::Calculator do
  subject(:calculator) { described_class.new }

  let(:quantity) { 4 }
  let(:bulk_purchase_result) { 2.0 }
  let(:slug) { 'bulk-purchase' }

  let(:item_entity_klass) { Items::Domain::Entity }
  let(:item_entity_instance) { instance_double(item_entity_klass) }

  let(:pricing_rule_entity_klass) { PricingRules::Domain::Entity }
  let(:pricing_rule_entity_instance) { instance_double(pricing_rule_entity_klass) }

  let(:promotion_entity_klass) { Promotions::Domain::Entity }
  let(:promotion_entity_instance) { instance_double(promotion_entity_klass, slug:) }

  let(:bulk_purchase_klass) { Shared::Price::Discount::Calculators::BulkPurchase }
  let(:bulk_purchase_instance) { instance_double(bulk_purchase_klass, call: bulk_purchase_result) }

  before do
    allow(item_entity_klass).to receive(:new).and_return(item_entity_instance)
    allow(pricing_rule_entity_klass).to receive(:new).and_return(pricing_rule_entity_instance)
    allow(promotion_entity_klass).to receive(:new).and_return(promotion_entity_instance)
    allow(bulk_purchase_klass).to receive(:new).and_return(bulk_purchase_instance)
  end

  context 'when calculable is nil' do
    context 'without pricing_rule' do
      it 'returns 0' do
        expect(calculator.call(item_entity_instance, quantity)).to eq(0)
      end

      it 'does not call the bulk_purchase calculator' do
        calculator.call(item_entity_instance, quantity)

        expect(bulk_purchase_klass).not_to have_received(:new)
      end
    end

    context 'with pricing_rule' do
      it 'returns 0' do
        expect(calculator.call(item_entity_instance, quantity, pricing_rule_entity_instance)).to eq(0)
      end

      it 'does not call the bulk_purchase calculator' do
        calculator.call(item_entity_instance, quantity, pricing_rule_entity_instance)

        expect(bulk_purchase_klass).not_to have_received(:new)
      end
    end
  end

  context 'when calculable exists' do
    context 'without pricing_rule' do
      let(:pricing_rule) { nil }

      it 'returns 0' do
        expect(calculator.call(item_entity_instance, quantity, pricing_rule, promotion_entity_instance)).to eq(0)
      end

      it 'does not call the bulk_purchase calculator' do
        calculator.call(item_entity_instance, quantity, pricing_rule, promotion_entity_instance)

        expect(bulk_purchase_klass).not_to have_received(:new)
      end
    end

    context 'with pricing_rule' do
      it 'calls the expected calculator instance' do
        calculator.call(item_entity_instance, quantity, pricing_rule_entity_instance, promotion_entity_instance)

        expect(bulk_purchase_klass).to have_received(:new).with(
          { options: { pricing_rule: pricing_rule_entity_instance, quantity:, record: item_entity_instance } }
        )
        expect(bulk_purchase_instance).to have_received(:call).once
      end

      it 'returns the bulk-purchase "call" method result' do
        expect(
          calculator.call(item_entity_instance, quantity, pricing_rule_entity_instance, promotion_entity_instance)
        ).to eq(bulk_purchase_result)
      end
    end
  end
end
