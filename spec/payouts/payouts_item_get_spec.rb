require_relative '../test_harness'
require_relative '../payouts/payouts_helper'
require 'json'

include PaypalPayoutsSdk::Payouts

describe PayoutsItemGetRequest do

  it 'Retrieve a Payout item details' do
    create_response = PayoutsHelper::create_payouts()
    expect(create_response.status_code).to eq(201)
    get_response = PayoutsHelper::get_payouts(create_response.result.batch_header.payout_batch_id)

    puts 'Retrieve a Payout item details'
    puts get_response

    expect(get_response.status_code).to eq(200)
    resp = PayoutsHelper::get_payouts_item(get_response.result.items[0].payout_item_id)

    expect(resp.status_code).to eq(200)
    expect(resp.result).not_to be_nil

    expect(resp.result.payout_item_id).to_not be_nil
    expect(resp.result.transaction_status).to_not be_nil
    expect(resp.result.payout_item.amount.value).to eq('1.00')
    expect(resp.result.payout_item.amount.currency).to eq('USD')
    expect(resp.result.payout_item.sender_item_id).to eq('Test_txn_1')
    expect(resp.result.payout_item.receiver).to eq('payout-sdk-1@paypal.com')
  end
end