class AddFieldsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :username, :string
    add_column :users, :stripe_customer_id, :string
    add_column :users, :plan, :integer
    add_column :users, :subscribed, :boolean
  end
end
