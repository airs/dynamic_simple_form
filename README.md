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

Declare dynamic_simple_form in your model.

```ruby
class Product < ActiveRecord::Base
  # dynamic_simple_form create association automatically
  # CustomType has many CustomFields
  # Product has one CustomType
  # Product has many FieldValues as values
  dynamic_simple_form type_class: CustomType,   # default => ProductType
                      field_class: CustomField  # default => ProductField
                      value_class: FieldValue   # default => ProductFieldValue

  # Model has also static fields
  validates :name, presence: true
  validates :price, numericality: { only_integer: true }
end
```

Run the dynamic_simple_form generator

```sh
rails generate dynamic_simple_form product description:text sale:boolean
```

## Requirements

* Ruby >= 1.9
* Rails >= 3

## Dependencies

* SimpleForm >= 3.0.0.beta1

