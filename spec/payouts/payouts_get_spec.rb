require_relative '../test_harness'
require_relative '../payouts/payouts_helper'
require 'json'

include PaypalPayoutsSdk::Payouts

describe PayoutsGetRequest do

  it 'Retrieve a Payouts Batch details' do
    create_response = PayoutsHelper::create_payouts()
    expect(create_response.status_code).to eq(201)
    resp = PayoutsHelper::get_payouts(create_response.result.batch_header.payout_batch_id)

    puts 'Retrieve a Payouts Batch details'
    puts resp.status_code
    puts resp.result
    expect(resp.status_code).to eq(200)
    expect(resp.result).not_to be_nil

    responseBody = resp.result

    expect(responseBody.batch_header.payout_batch_id).not_to be_nil
    expect(responseBody.batch_header.batch_status).not_to be_nil
    expect(responseBody.batch_header.sender_batch_header.email_subject).to eq('This is a test transaction from SDK')
    expect(responseBody.batch_header.sender_batch_header.email_message).to eq('SDK payouts test txn')

    expect(responseBody.total_items).to eq(5)
    expect(responseBody.total_pages).to eq(1)
    expect(responseBody.items).to_not be_nil
    expect(responseBody.items.length).to eq(5)

    firstPayout = responseBody.items[0]
    expect(firstPayout.payout_item_id).to_not be_nil
    expect(firstPayout.transaction_status).to_not be_nil
    expect(firstPayout.payout_item.amount.value).to eq('1.00')
    expect(firstPayout.payout_item.amount.currency).to eq('USD')
    expect(firstPayout.payout_item.sender_item_id).to eq('Test_txn_1')
    expect(firstPayout.payout_item.receiver).to eq('payout-sdk-1@paypal.com')
  end
end
