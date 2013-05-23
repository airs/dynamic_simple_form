require 'rails'

require 'dynamic_simple_form/version'
require 'dynamic_simple_form/root'
require 'dynamic_simple_form/type'
require 'dynamic_simple_form/field'
require 'dynamic_simple_form/field_value'
require 'dynamic_simple_form/file_uploader'
require 'dynamic_simple_form/macro'

module DynamicSimpleForm
  class Railtie < Rails::Railtie
    initializer 'dynamic_simple_form.insert_into_active_record' do
      ActiveSupport.on_load :active_record do
        ActiveRecord::Base.send(:include, DynamicSimpleForm::Macro)
      end
    end
  end

  def self.root
    Pathname(__FILE__).join('..', '..')
  end
end
