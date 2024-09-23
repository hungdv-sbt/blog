class PostDecorator < ApplicationDecorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
  def created_at
    object.created_at.strftime('%m/%d/%y')
  end

  def show_status(show: false)
    return unless show

    h.content_tag :p, class: 'status' do
      object.status.capitalize
    end
  end
end
