class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :login,  :string 
      t.column :email, :string 
      t.column :password , :string
      t.column :session_id, :string
      t.column :authorization_token, :string
      t.column :data, :text
      t.column :active, :boolean
      t.column :enabled, :boolean 
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
