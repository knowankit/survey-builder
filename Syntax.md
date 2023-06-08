# Survey builder


## How to create a rails API project
```sh
rails new project_name --api
```

## How to add resource
```sh
rails g resource table_name column_name column_name
```

Add types with this

```sh
rails g resource table_name name:string is_confirmed:boolean
```

## Migrate

```sh
rails db:migrate
```

## Start the rail server

```sh
rails s
```

## How to add a new table?

```sh
rails generate migration CreateTableName
```

A new migration file will be created with name as `timestamp_create_table_name.rb` in `db/migrate` folder. We can add the column with their types and default as below skeleton.

```ruby
def change
  create_table :table_name do |t|
    t.string :column1
    t.integer :column2
    t.boolean :column3, default: false

    t.timestamps
  end
end

```

Run `rails db:migrate` to execute

## How to drop / delete a table?

```sh
rails generate migration DropTableName
```

Add the below code in the new migration file

```ruby
def change
  drop_table :table_name
end
```

Run `rails db:migrate` to execute

## How to add columns to existing table

```sh
rails generate migration AddColumnNameToTableName column_name:data_type
```

Add below code now

```ruby
def change
  add_column :table_name, :column_name, :data_type, default: 'default value'
end
```

run `rails db:migrate`

## How to remove column

```sh
rails generate migration RemoveColumnNameFromTableName
```

add below code,

```ruby
remove_column :table_name, :column_name
```

run `rails db:migrate`
