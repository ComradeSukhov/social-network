module ApplicationHelper
  def display_year(obj)
    obj.created_at.year != Time.current.year ? ' %Y ' : ' '
  end

  def creation_time(obj)
    obj.created_at.strftime("%d %b#{ display_year(obj) }at %H:%M")
  end
end
