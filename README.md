# Luncher

An example Rails app for ordering lunches ([Live Demo](https://zluncher.herokuapp.com "Live Demo")).

[![Build Status](https://travis-ci.org/zinovyev/luncher.svg?branch=master)](https://travis-ci.org/zinovyev/luncher)

## About

Luncher is a Rails app for ordering lunches with multi organization support.
The first logged in user becomes a lunches admin and can rule menus and prices.
Each newly created user should be approved by the lunches admin to be able to make orders.

## Features

* Weekly menus;
* Multi organization support;
* Authentication via Google Apps;


## Installation

You should have several environment variables enabled to make the application work fine:
* `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` for Google Auth;
* `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_REGION` for Amazone S3 storage;

You should also install seeds cause default Organization should be created in order the application to work properly.

## Instructions

**Admin**:

* Te first logged in user becomes a lunches admin;
* Lunches Admin has a dropdown menu at the bottom panel;
* As a lunches admin, first you have to create several menu items (Dropdown Menu -> "Items");
* Then you should combine a weekly menu of them (Dropdown Menu -> "Organizations", then click "Weekly Menu");
* Then you should create price items for every day on the organizations page (Click "New Price" button)
* You can also inspect user's orders: (Dropdown Menu -> "Orders");
* To rule organizations use Organizations panel (Dropdown Menu -> "Organizations);
* To rule users use Users panel (Dropdown Menu -> "Users");

**User**:

* You have a calendar on the dashboard page;
* The days available for ordering items in your organization are highlighted with green;
* When you click a link you can now format an order;
* Click "Add To Order" button to select an item;
* CLick button again to unselect it;

## TODO
[TODO list](/doc/todo.md)

