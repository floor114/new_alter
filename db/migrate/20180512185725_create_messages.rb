class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages, id: :uuid do |t|
      t.text :body
      t.string :status, default: Message::CREATED
      t.uuid :user_id
      t.string :receiver_type
      t.uuid :receiver_id

      t.timestamps
    end
  end
end
