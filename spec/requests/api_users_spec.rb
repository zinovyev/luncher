require 'rails_helper'
require 'json'

RSpec.describe 'Api users controller', type: :request do
  let!(:users) { create_list(:user, 15) }
  let!(:orders) do
    orders = []
    users.each do |user|
      items = create_list(:item_with_prices, 3, prices_count: 1)
      orders << create(:order,
                       user: user,
                       main_course: items[0].prices.first,
                       first_course: items[1].prices.first,
                       drink: items[2].prices.first)
    end
  end
  let!(:api_key) { create(:api_key) }

  it 'shows the first page of the orders list' do
    get api_v1_orders_path,
      params: {},
      headers: { 'Authorization' => "Token token=#{api_key.access_token}" }

    expect(response).to have_http_status(200)

    data = JSON.parse(response.body)
    first_order_data = data.first
    order = Order.find(first_order_data['id'])

    expect(data.count).to eq 10
    expect(first_order_data['id']).to eq order.id
    expect(first_order_data['user_id']).to eq order.user_id
    expect(first_order_data['created_at']).to eq order.created_at.strftime('%Y-%m-%d')
    expect(first_order_data['first_course']['price']).to eq order.first_course.price.to_s
    expect(first_order_data['main_course']['title']).to eq order.main_course.title
    expect(first_order_data['drink']['image']).to eq order.drink.image_url
  end

  it 'shows the second page of the orders list' do
    get api_v1_orders_path,
      params: { page: 2 },
      headers: { 'Authorization' => "Token token=#{api_key.access_token}" }

    expect(response).to have_http_status(200)

    data = JSON.parse(response.body)
    expect(data.count).to eq 5
  end

  it 'shows a detailed information about a user' do
    user = users.first
    get api_v1_user_path(user),
      params: {},
      headers: { 'Authorization' => "Token token=#{api_key.access_token}" }

    expect(response).to have_http_status(200)

    user_data = JSON.parse(response.body)
    expect(user_data['id']).to eq user.id
    expect(user_data['name']).to eq user.name
    expect(user_data['email']).to eq user.email
    expect(user_data['lunches_admin']).to eq user.lunches_admin
  end
end
