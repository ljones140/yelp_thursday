require 'rails_helper'

feature 'reviewing' do

  before do
    # Restaurant.create name: 'KFC'
    register_user
    create_restaurant
  end

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('3 /5')
  end

  scenario 'user can only leave one review per restaurant' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
    visit '/restaurants'
    click_link 'Review KFC'
    expect(page).not_to have_button('Leave Review')
    #expect(page).to have_content('placeholder error')
  end

end

#feature 'deleting reviews' do
 # before do
  #  Restaurant.create name: 'Pilpel'
   # restaurant = Restaurant.find(name: 'Pilpel')
    #restaurant.reviews(thoughts: 'It was yummy', rating: 4)
  #end

 # scenario 'deletes all dependencies of the restaurant' do
  #  visit '/restaurants'
   # click_link 'Delete Pilpel'
   # expect(page).not_to have_content 'Pilpel'
   # expect()
  #end
#end
