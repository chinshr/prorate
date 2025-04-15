# Rails backend

## Setup

Check versions, mine is:

```
$ ruby --version
ruby 3.4.1 (2024-12-25 revision 48d4efcb85) +PRISM [arm64-darwin24]

$ bundler --version
Bundler version 2.6.3
```

Do the following before starting the server:

```
bundle install
rails db:create
rails db:migrate
rails db:seed
```

Note: `rails s -p 3001` or use the `start.sh` script in the root folder to run this backend and the frontend togehter.

## Test

Run the tests with

```
bundle exec rails test test/controllers/api/prorate_controller_test.rb
```

## API

curl http://localhost:3000/api/investors
curl http://localhost:3000/api/investors?query=inve
curl http://localhost:3000/api/investors/investor-a
curl http://localhost:3000/api/investors/investor-a/investments

```
curl -X POST http://localhost:3000/api/prorate \
  -H "Content-Type: application/json" \
  -d '{
    "allocation_amount": 100,
    "investor_amounts": [
      {
        "name": "Investor A",
        "requested_amount": 100,
        "average_amount": 100
      },
      {
        "name": "Investor B",
        "requested_amount": 25,
        "average_amount": 25
      }
    ]
  }'
```

returns `{"Investor A":80.0,"Investor B":20.0}`
