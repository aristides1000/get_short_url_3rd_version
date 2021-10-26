# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Url, type: :model do
  describe 'validations' do
    it 'validates original URL is a valid URL' do
      @url = Url.new(short_url: 'RSJRW', original_url: 'hi, I am a URL :D', clicks_count: 20)
      @url.save
      @url2 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url2.save
      expect(Url.all.count).to eq(1)
    end

    it 'validates short URL is present' do
      @url = Url.new(short_url: nil, original_url: 'https://www.amazon.com/', clicks_count: 20)
      @url.save
      @url2 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url2.save
      expect(Url.all.count).to eq(1)
    end

    it 'long_url is not repeated' do
      @url = Url.new(short_url: 'RSJRW', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url.save
      @url2 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url2.save
      expect(Url.all.count).to eq(1)
    end

    it 'short_url lenght can only be 5' do
      @url = Url.new(short_url: 'RSJR', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url.save
      @url2 = Url.new(short_url: 'RSJRADF', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url2.save
      @url3 = Url.new(short_url: 'RSJRA', original_url: 'https://api.rubyonrails.org/v5.2/classes/ActionDispatch/SystemTestCase.html', clicks_count: 20)
      @url3.save
      expect(Url.all.count).to eq(1)
    end
  end
end
