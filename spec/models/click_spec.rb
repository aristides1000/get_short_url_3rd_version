# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Click, type: :model do
  describe 'validations' do
    it 'validates url_id is valid' do
      @url = Url.new(short_url: 'RSJRW', original_url: 'https://www.amazon.com/', clicks_count: 20)
      @url.save
      @url2 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url2.save
      expect(Url.first.id != Url.last.id).to eq(true)
    end

    it 'validates browser is not null' do
      @url = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url.save
      @click = @url.clicks.new(platform: 'windows10' , browser: 'chrome')
      @click.save
      @click2 = @url.clicks.new(platform: 'windows10' , browser: nil)
      @click2.save
      expect(@url.clicks.count).to eq(1)
    end

    it 'validates platform is not null' do
      @url = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url.save
      @click = @url.clicks.new(platform: 'windows10' , browser: 'chrome')
      @click.save
      @click2 = @url.clicks.new(platform: nil , browser: 'chrome')
      @click2.save
      expect(@url.clicks.count).to eq(1)
    end
  end
end
