class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :password
      t.string :profile_image
      t.string :auth_token
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.timestamps
    end
  end
end
