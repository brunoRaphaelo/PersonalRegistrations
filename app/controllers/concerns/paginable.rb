# frozen_string_literal: true

module Paginable
  extend ActiveSupport::Concern

  DEFAULT_INITIAL_PAGE = 1
  DEFAULT_RESOURCES_PER_PAGE = 25

  included do
    def paginate_it(resources)
      return resources.class.show.find(resources.id) unless resources.is_a?(Enumerable)

      resources = ::Kaminari.paginate_array(resources) if resources.is_a?(Array)

      resources.page(resources_page).per(resources_per_page)
    end
  end

  private

  def resources_page
    params[:page] || DEFAULT_INITIAL_PAGE
  end

  def resources_per_page
    params[:per_page] || DEFAULT_RESOURCES_PER_PAGE
  end
end
