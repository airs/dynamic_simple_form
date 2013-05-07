# encoding: utf-8
require 'carrierwave/uploader'

class DynamicSimpleForm::FileUploader < CarrierWave::Uploader::Base
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end
end
