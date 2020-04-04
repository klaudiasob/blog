# frozen_string_literal: true

module ApplicationHelper
  def octicon_btn(icon, path)
    link_to Octicons::Octicon.new(icon, height: 30).to_svg.html_safe, path,
            class: 'btn btn-light', style: 'float: left;'
  end

  def octicon(icon, size = 17)
    Octicons::Octicon.new(icon, height: size).to_svg.html_safe
  end

  def notifications_count
    Notification.where(recipient_id: current_owner.id, read: false).count
  end
end
