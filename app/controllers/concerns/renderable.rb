# frozen_string_literal: true

module Renderable
  extend ActiveSupport::Concern

  # Concerns
  include Sortable
  include Paginable

  included do
    def render_json_for(records, status:)
      render json: paginate_it(sort_by_params(records)),
             key_transform: default_key_transform,
             count: total_of(records),
             status:
    end

    def render_json_errors_for(errors_resource, status:)
      render json: errors_resource, status:
    end
  end

  private

  def default_key_transform
    request.headers['default-key-transform']&.to_sym
  end

  def total_of(resources)
    resources.respond_to?(:length) ? resources.length : 1
  end
end
