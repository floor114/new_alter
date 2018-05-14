# frozen_string_literal: true

class Message < ApplicationRecord
  enum status: {
    created: CREATED = 'created',
    read: READ = 'read'
  }

  belongs_to :user
  belongs_to :receiver, polymorphic: true
end
