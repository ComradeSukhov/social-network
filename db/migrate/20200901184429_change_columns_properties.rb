class ChangeColumnsProperties < ActiveRecord::Migration[6.0]
  def change
    change_column_null :comments, :body, false
    change_column_null :posts,    :body, false
  end
end
