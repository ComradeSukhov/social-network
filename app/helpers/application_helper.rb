module ApplicationHelper
  # ===> Time related helpers <===
  def insert_year_directive_for(obj)
    obj.created_at.year == Time.now.year ? ' ' : ' %Y '
  end

  def formatted_creation_time_of(obj)
    obj.created_at.strftime("%d %b#{ insert_year_directive_for(obj) }at %H:%M")
  end
end
