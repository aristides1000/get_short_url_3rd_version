# frozen_string_literal: true

class Click < ApplicationRecord
  belongs_to :url

  validates :browser , presence: true
  validates :platform , presence: true
  
  scope :current_month, -> {where('created_at >= ?', Time.now.at_beginning_of_month)}
end
