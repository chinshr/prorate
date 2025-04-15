# API

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
