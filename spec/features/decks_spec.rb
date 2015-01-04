require "rails_helper"
require "spec_helper"

feature "Deck building" do
  scenario "User creates a deck and adds a card to his/her deck" do
    user = create(:user)

    visit root_path
    click_link 'Login'
    fill_in 'session_user_name', with: user.username
    fill_in 'session_user_password', with: user.password
    click_button 'Log In'

    deck = user.create_deck(name: "Yeah")
    card = create(:card)

    visit deck_path(deck)
    expect(current_path).to eq deck_path(deck)
    expect(page).to have_content 'Add Card to Deck'
    expect {
      click_link 'Add Card to Deck'
    }.to change(deck.cards, :count).by(1)
    expect {
      click_link 'Remove Card From Deck'
    }.to change(deck.cards, :count).by(-1)
  end
end