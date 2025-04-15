#!/bin/bash

# Start Rails server
cd backend
rails server -p 3001 &

# Start Next.js server
cd ../website
npm run dev -- -p 3000 