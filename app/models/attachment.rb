# frozen_string_literal: true
class Attachment < ApplicationRecord
  mount_uploader :file, ImageUploader
end
