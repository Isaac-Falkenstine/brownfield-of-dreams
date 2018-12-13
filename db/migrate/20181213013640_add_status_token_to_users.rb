class AddStatusTokenToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status_token, :string
  end
end
