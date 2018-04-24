class AddPhototoRequests < ActiveRecord::Migration[5.0]
  def change
    add_attachment :requests, :photo
  end
end
