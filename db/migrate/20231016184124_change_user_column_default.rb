class ChangeUserColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :users, :bio, nil
  end
end
