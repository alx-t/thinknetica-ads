Sequel.migration do
  change do
    create_table :ads do
      primary_key :id
      String :title, null: false
      String :description, text: true, null: false
      String :city, null: false
      Bignum :user_id, null: false
      Float :lat
      Float :lon
      DateTime :created_at, null: false
      DateTime :updated_at, null: false

      index :user_id
    end
  end
end