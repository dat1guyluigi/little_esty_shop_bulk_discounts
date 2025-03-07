require 'rails_helper'

RSpec.describe 'discount index page' do
  before(:each) do
    @merchant = Merchant.create!(name: "John Sandman")
    @discount1 = @merchant.discounts.create!(percentage: 20, threshold: 10, name: "Discount 1")
    @discount2 = @merchant.discounts.create!(percentage: 7, threshold: 12, name: "Discount 2")
    visit merchant_discounts_path(@merchant)
    save_and_open_page
  end

  it 'shows all discounts with their info' do
    expect(page).to have_content(@discount1.percentage)
    expect(page).to have_content(@discount1.threshold)
    expect(page).to have_content(@discount1.name)
    expect(page).to have_content(@discount2.percentage)
    expect(page).to have_content(@discount2.threshold)
    expect(page).to have_content(@discount2.name)
  end

  it 'has a link to each discounts show page' do
    click_link(@discount1.percentage)

    expect(current_path).to eq(merchant_discount_path(@merchant, @discount1))
  end

  it 'has a link to create a new discount' do
    expect(page).to have_content("Create new discount")
    click_link("Create new discount")
    expect(current_path).to eq(new_merchant_discount_path(@merchant))
  end

  it 'has a link to delete an existing discount' do
    expect(page).to have_content("Delete #{@discount1.name}")

    click_link("Delete #{@discount1.name}")

    expect(current_path).to eq(merchant_discounts_path(@merchant))
    expect(page).to have_content("Discount deleted.")
    expect(page).to_not have_content(@discount1.name)
  end

  it 'has a link to edit an existing discount' do
    expect(page).to have_content("Edit #{@discount1.name}")

    click_link("Edit #{@discount1.name}")

    expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
  end

  it 'shows the next 3 holidays' do
    expect(page).to have_content("Columbus Day")
    expect(page).to have_content("Veterans Day")
    expect(page).to have_content("Thanksgiving Day")
  end
end
