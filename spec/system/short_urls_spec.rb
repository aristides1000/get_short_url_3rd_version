# frozen_string_literal: true

require 'rails_helper'
require 'webdrivers'

# WebDrivers Gem
# https://github.com/titusfortner/webdrivers
#
# Official Guides about System Testing
# https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html

RSpec.describe 'Short Urls', type: :system do
  before do
    driven_by :selenium, using: :headless_chrome
    @url = Url.new(short_url: 'RSJRW', original_url: 'https://github.com/titusfortner/webdrivers', clicks_count: 20)
    @url.save

    @url2 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
    @url2.save

    @url3 = Url.new(short_url: 'RSJRB', original_url: 'https://github.com/fullstacklabs/hey-url-challenge-code/blob/master/CHALLENGE.md', clicks_count: 20)
    @url3.save

    @url4 = Url.new(short_url: 'RSJRC', original_url: 'https://stackoverflow.com/questions/1627679/whats-the-most-efficient-way-get-the-first-day-of-the-current-month', clicks_count: 20)
    @url4.save

    @url5 = Url.new(short_url: 'RSJRD', original_url: 'https://www.youtube.com/watch?v=OXL_-Rh8_48', clicks_count: 20)
    @url5.save

    @url6 = Url.new(short_url: 'RSJRE', original_url: 'https://www.amazon.com/', clicks_count: 20)
    @url6.save

    @url7 = Url.new(short_url: 'RSJRF', original_url: 'https://www.youtube.com/', clicks_count: 20)
    @url7.save

    @url8 = Url.new(short_url: 'RSJRG', original_url: 'https://www.youtube.com/watch?v=A96Y9wFhlnw', clicks_count: 20)
    @url8.save

    @url9 = Url.new(short_url: 'RSJRH', original_url: 'https://www.youtube.com/watch?v=oHVVqPTbwHM', clicks_count: 20)
    @url9.save

    @url10 = Url.new(short_url: 'RSJRI', original_url: 'https://www.youtube.com/watch?v=bwCjfJvN6Y4', clicks_count: 20)
    @url10.save
    # If using Firefox
    # driven_by :selenium, using: :firefox
    #
    # If running on a virtual machine or similar that does not have a UI, use
    # a headless driver
    # driven_by :selenium, using: :headless_chrome
    # driven_by :selenium, using: :headless_firefox
  end

  describe 'index' do
    it 'expect page to show 10 urls' do
      visit root_path
      expect(page).to have_text('RSJRW')
      expect(page).to have_text('RSJRA')
      expect(page).to have_text('RSJRB')
      expect(page).to have_text('RSJRC')
      expect(page).to have_text('RSJRD')
      expect(page).to have_text('RSJRE')
      expect(page).to have_text('RSJRF')
      expect(page).to have_text('RSJRG')
      expect(page).to have_text('RSJRH')
      expect(page).to have_text('RSJRI')
      # expect page to show 10 urls
    end
  end

  describe 'show' do
    it 'shows a panel of stats for a given short url' do
      visit url_path('RSJRW')
      expect(page).to have_text('Original URL: https://github.com/titusfortner/webdrivers')
      expect(page).to have_text('Stats for http://127.0.0.1:3000/RSJRW')
      # expect page to show the short url
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit url_path('NOTFOUND')
        expect(page).to have_text('404 page not found!!...')
        # expect page to be a 404
      end
    end
  end

  describe 'create' do
    context 'when url is valid' do
      it 'creates the short url' do
        visit '/'
        fill_in 'Your original URL here', with: 'https://www.wizardingworld.com/'
        click_button 'Shorten URL'
        expect(page).to have_text('https://www.wizardingworld.com/')
        # add more expections
      end

      it 'redirects to the home page' do
        visit '/'
        expect(page).to have_text('RSJRW')
        # add more expections
      end
    end

    context 'when url is invalid' do
      it 'does not create the short url and shows a message' do
        visit '/'
        fill_in 'Your original URL here', with: 'hi, I am a URL :D'
        click_button 'Shorten URL'
        expect(page).to have_text('Invalid Url, empty or invalid url formats are not allowed!')
        # add more expections
      end

      it 'redirects to the home page' do
        visit '/'
        expect(page).to have_text('HeyURL!')
        # add more expections
      end
    end
  end

  describe 'visit' do
    it 'redirects the user to the original url' do
      visit visit_path('RSJRW')
      expect(page).to have_text('Redirecting to page')
      # add more expections
    end

    context 'when not found' do
      it 'shows a 404 page' do
        visit visit_path('NOTFOUND')
        expect(page).to have_text('Error 404, Short link not found')
      end
    end
  end
end
