class AddTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :token, :string
    add_column :users, :github_id, :integer
    add_column :users, :user_id, :integer
  end
end
