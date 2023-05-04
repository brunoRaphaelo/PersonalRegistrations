class EnableExtensions < ActiveRecord::Migration[7.0]
  def change
    enable_extension('unaccent') unless extension_enabled?('unaccent')
    enable_extension('pgcrypto') unless extension_enabled?('pgcrypto')
  end
end
