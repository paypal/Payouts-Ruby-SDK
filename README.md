# PayPal Payouts API SDK for Ruby

![PayPal Developer](homepage.jpg)

__Welcome to PayPal Ruby SDK__. This repository contains PayPal's NodeJS SDK and samples for [v1/payments/payouts](https://developer.paypal.com/docs/api/payments.payouts-batch/v1/) APIs.

This is a part of the next major PayPal SDK. It includes a simplified interface to only provide simple model objects and blueprints for HTTP calls. This repo currently contains functionality for PayPal Payouts APIs which includes [Payouts](https://developer.paypal.com/docs/api/payments.payouts-batch/v1/).

Please refer to the [PayPal Payouts Integration Guide](https://developer.paypal.com/docs/payouts/) for more information. Also refer to [Setup your SDK](https://developer.paypal.com/docs/payouts/reference/setup-sdk) for additional information about setting up the SDK's.

## Prerequisites

- Ruby 2.0.0 or above
- Bundler

## Usage
### Binaries

It is not mandatory to fork this repository for using the PayPal SDK. You can refer [PayPal Payouts SDK](https://developer.paypal.com/docs/payouts/reference/setup-sdk/#install-the-sdk) for configuring and working with SDK without forking this code.

For contributing or referring the samples, You can fork/refer this repository. 

### Setting up credentials
Get client ID and client secret by going to https://developer.paypal.com/developer/applications and generating a REST API app. Get <b>Client ID</b> and <b>Secret</b> from there.

```ruby
require 'paypal-payouts-sdk'
  

# Creating Access Token for Sandbox
client_id = "PAYPAL-CLIENT-ID"
client_secret = "PAYPAL-CLIENT-SECRET"
# Creating an environment
environment = PayPal::SandboxEnvironment.new(client_id, client_secret)
client = PayPal::PayPalHttpClient.new(environment)
```

## Examples

### Creating a Payouts
This code creates a Payout and prints the batch_id for the Payout.
#### Code: 
```ruby

# Construct a request object and set desired parameters
# Here, PayoutsPostRequest::new creates a POST request to /v1/payments/payouts
body = {
  sender_batch_header: {
      recipient_type: 'EMAIL',
      email_message: 'SDK payouts test txn',
      note: 'Enjoy your Payout!!',
      sender_batch_id: 'Test_SDK_1',
      email_subject: 'This is a test transaction from SDK'
  },
  items: [{
              note: 'Your 5$ Payout!',
              amount: {
                  currency: 'USD',
                  value: '1.00'
              },
              receiver: 'payout-sdk-1@paypal.com',
              sender_item_id: 'Test_txn_1'
          }, {
              note: 'Your 5$ Payout!',
              amount: {
                  currency: 'USD',
                  value: '1.00'
              },
              receiver: 'payout-sdk-2@paypal.com',
              sender_item_id: 'Test_txn_2'
          }, {
              note: 'Your 5$ Payout!',
              amount: {
                  currency: 'USD',
                  value: '1.00'
              },
              receiver: 'payout-sdk-3@paypal.com',
              sender_item_id: 'Test_txn_3'
          }, {
              note: 'Your 5$ Payout!',
              amount: {
                  currency: 'USD',
                  value: '1.00'
              },
              receiver: 'payout-sdk-4@paypal.com',
              sender_item_id: 'Test_txn_4'
          }, {
              note: 'Your 5$ Payout!',
              amount: {
                  currency: 'USD',
                  value: '1.00'
              },
              receiver: 'payout-sdk-5@paypal.com',
              sender_item_id: 'Test_txn_5'
          }]
}
request = PaypalPayoutsSdk::Payouts::PayoutsPostRequest::new
request.request_body(body) 

begin
    # Call API with your client and get a response for your call
    response = client.execute(request)

    # If call returns body in response, you can get the deserialized version from the result attribute of the response
    batch_id = response.result.batch_header.payout_batch_id
    puts batch_id
rescue PayPalHttp::HttpError => ioe
    # Something went wrong server-side
    puts ioe.status_code
    puts ioe.headers["debug_id"]
end
```

### Retrieve a Payout Batch
Pass the batch_id from the previous sample to retrieve Payouts batch details

#### Code:
```ruby
# Here, PayoutsGetRequest::new() creates a GET request to /v1/payments/payouts/<batch-id>
request = PaypalPayoutsSdk::Payouts::PayoutsGetRequest::new("PAYOUT-BATCH-ID")
request.page(1)
request.page_size(10)
request.total_required(true)

begin
    # Call API with your client and get a response for your call
    response = client.execute(request) 
    
    # If call returns body in response, you can get the deserialized version from the result attribute of the response
    batch_status = response.result.batch_header.batch_status
    puts batch_status
rescue PayPalHttp::HttpError => ioe
    # Something went wrong server-side
    puts ioe.status_code
    puts ioe.headers["debug_id"]
end
```

## Running tests

To run integration tests using your client id and secret, clone this repository and run the following command:
```sh
$ bundle install
$ PAYPAL_CLIENT_ID=YOUR_SANDBOX_CLIENT_ID PAYPAL_CLIENT_SECRET=YOUR_SANDBOX_CLIENT_SECRET rspec spec
```

## Samples

You can start off by trying out [Payouts Samples](samples/run_all.rb)

To try out different samples head to [this link](samples)

Note: Update the `paypal_client.rb` with your sandbox client credentials or pass your client credentials as environment variable while executing the samples.


## License
Code released under [SDK LICENSE](LICENSE)


