# frozen_string_literal: true

module ApplicationHelper
  def clickConfirmationMessage(msg)
    ans = ''
    case msg
      when 'redirect'
        ans = 'Redirecting to page, if page doesnt open click on the link...'
      when '404'
        ans = "Error 404, Short link not found"
      when 'unable'
        ans = "Sorry, ther ewas an error trying to acces this link"
      else
        ans = 'nothing'
    end
    ans
  end
end
