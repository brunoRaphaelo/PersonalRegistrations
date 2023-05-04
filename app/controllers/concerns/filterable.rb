# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    def apply_filters(objects, *scopes)
      scopes.each do |scope|
        scope_string = scope.to_s
        param_name = scope_string.sub('by_', '')
        params_item = params[param_name]
        params_item = nil if params_item == 'null'

        next unless params_item && objects.respond_to?(scope)

        objects = objects.send(scope, params_item)
      end

      objects
    end
  end
end
