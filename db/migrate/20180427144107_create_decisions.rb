class CreateDecisions < ActiveRecord::Migration[5.0]
  def change
    create_table :decisions, id: :uuid do |t|
      t.text :description
      t.uuid :user_id
      t.uuid :request_id
      t.string :status, default: Decision::CREATED

      t.timestamps
    end
  end
end
