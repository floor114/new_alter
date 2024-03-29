class AddAdditionalInfoToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :info, :text
    add_column :users, :phone_number, :string
    add_attachment :users, :avatar
  end
end
