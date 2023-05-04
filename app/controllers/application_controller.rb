class ApplicationController < ActionController::API
  # Concerns
  include Renderable
  include Filterable
  include Paginable
  include Sortable
end
