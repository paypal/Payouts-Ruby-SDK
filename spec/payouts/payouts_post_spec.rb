require_relative '../test_harness'
require_relative '../payouts/payouts_helper'
require 'json'

include PaypalPayoutsSdk::Payouts

describe PayoutsPostRequest do
  it 'Creates a Payouts batch' do
    resp = PayoutsHelper::create_payouts()

    puts 'Creates a Payouts batch'
    puts resp

    expect(resp.status_code).to eq(201)
    expect(resp.result).not_to be_nil

    responseBody = resp.result
    expect(responseBody.batch_header.payout_batch_id).not_to be_nil
    expect(responseBody.batch_header.batch_status).not_to be_nil
    expect(responseBody.batch_header.sender_batch_header.email_subject).to eq('This is a test transaction from SDK')
    expect(responseBody.batch_header.sender_batch_header.email_message).to eq('SDK payouts test txn')
  end
end
