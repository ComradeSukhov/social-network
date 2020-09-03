class ChangeColumnsNames < ActiveRecord::Migration[6.0]
  def change
    rename_column :comments, :user_id, :author_id
    rename_column :posts,    :user_id, :author_id
    rename_column :walls,    :user_id, :owner_id
  end
end
