require_relative '../test_harness'
require_relative '../payouts/payouts_helper'
require 'json'

include PaypalPayoutsSdk::Payouts

describe PayoutsItemCancelRequest do

  it 'Cancel an unclaimed Payout item' do
    puts 'Cancel an unclaimed Payout item'
    create_response = PayoutsHelper::create_payouts()
    expect(create_response.status_code).to eq(201)
    get_response = PayoutsHelper::get_payouts(create_response.result.batch_header.payout_batch_id)
    expect(get_response.status_code).to eq(200)

    var = 0
    until var == 5
      sleep 2
      get_response = PayoutsHelper::get_payouts(create_response.result.batch_header.payout_batch_id)
      expect(get_response.status_code).to eq(200)
      if get_response.result.batch_header.batch_status == 'SUCCESS'
        resp = PayoutsHelper::cancel_payouts_item(get_response.result.items[0].payout_item_id)

        puts resp
        expect(resp.status_code).to eq(200)
        expect(resp.result).not_to be_nil

        expect(resp.result.payout_item_id).to_not be_nil
        expect(resp.result.transaction_status).to_not be_nil
        expect(resp.result.transaction_status).to eq('RETURNED')
        expect(resp.result.payout_item.amount.value).to eq('1.00')
        expect(resp.result.payout_item.amount.currency).to eq('USD')
        expect(resp.result.payout_item.sender_item_id).to eq('Test_txn_1')
        expect(resp.result.payout_item.receiver).to eq('payout-sdk-1@paypal.com')
        break
      end
      var = var + 1
    end

    if var == 5
      expect(false).to be_truthy
    end

  end
end
