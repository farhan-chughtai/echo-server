class AddUniqueIndexToEndpoint < ActiveRecord::Migration[6.1]
  def change
    add_index :endpoints, [:verb, :path], unique: true
  end
end
