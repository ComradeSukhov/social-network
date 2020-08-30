class AddWallsRefToPosts < ActiveRecord::Migration[6.0]
  def change
    add_reference :posts, :wall, null: false, foreign_key: true
  end
end
