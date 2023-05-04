# frozen_string_literal: true

module CommonScopes
  extend ActiveSupport::Concern

  included do
    scope :by_id, ->(id) { where(id:) }
  end
end
