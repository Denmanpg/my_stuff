class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.string :subject
      t.text :body
      t.string :status,default: "unread"

      t.timestamps
    end
  end
end
