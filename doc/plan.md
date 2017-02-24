# Plan

## Relations
prices <- orders -> users
items <- prices
orders -> prices

## Tables
**order**: `price_id`, `user_id`
**item**: title + photo
**price**: item + price + date

