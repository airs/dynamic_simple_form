## Installation

Add it to your Gemfile:

```ruby
gem 'dynamic_simple_form'
```

Run the following command to install it:

```sh
bundle install
```

Run the simple_form generator:

```sh
rails generate simple_form:install
```

## Usage

Add {model}_type_id to your model OR create new your model with {model}_type_id.

```sh
rails generate migration AddProductTypeIdToProducts product_type_id:references
```

OR

```sh
rails generate migration CreateProduct product_type_id:references [and your columns...]
```

Declare dynamic_simple_form in your model.

```ruby
class Product < ActiveRecord::Base
  # dynamic_simple_form create association automatically.
  # CustomType has many CustomFields
  # Product belongs to CustomType
  # Product has many FieldValues as values
  dynamic_simple_form type_class: CustomType,   # default => ProductType
                      field_class: CustomField  # default => ProductField
                      value_class: FieldValue   # default => ProductFieldValue
                      type_dependent: :nullify   # default => :destroy

  # Model has also static fields
  validates :name, presence: true
  validates :price, numericality: { only_integer: true }
end
```

Run the dynamic_simple_form generator

```sh
rails generate dynamic_simple_form product description:text sale:boolean
```

Mount Engine

```ruby
mount DynamicSimpleForm::Engine => '/dynamic_simple_form'
```

## Requirements

* Ruby >= 1.9
* Rails >= 3

## Dependencies

* SimpleForm >= 3.0.0.beta1

## Todo

1. create engine
2. write lib/generators/USAGE
3. support check_boxes
