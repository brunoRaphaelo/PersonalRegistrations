class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  # Concerns
  include CommonScopes
end
