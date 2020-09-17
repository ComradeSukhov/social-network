module ApplicationHelper
  def insert_year(obj)
    obj.created_at.year == Time.now.year ? ' ' : ' %Y '
  end

  def creation_time(obj)
    obj.created_at.strftime("%d %b#{ insert_year(obj) }at %H:%M")
  end
end
