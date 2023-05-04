module CommonScopes
  extend ActiveSupport::Concern

  included do
    scope :by_id, ->(id) { where(id: id) }
  end
end
