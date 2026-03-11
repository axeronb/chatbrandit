class RebrandInstallationToGobrandit < ActiveRecord::Migration[7.0]
  BRANDING_CONFIGS = {
    'INSTALLATION_NAME' => 'GoBrandIt',
    'LOGO_THUMBNAIL' => '/brand-assets/logo_thumbnail.svg',
    'LOGO' => '/brand-assets/logo.svg',
    'LOGO_DARK' => '/brand-assets/logo_dark.svg',
    'BRAND_URL' => 'https://gobrandit.app',
    'WIDGET_BRAND_URL' => 'https://gobrandit.app',
    'BRAND_NAME' => 'GoBrandIt'
  }.freeze

  def up
    BRANDING_CONFIGS.each do |name, value|
      config = InstallationConfig.find_or_initialize_by(name: name)
      config.value = value
      config.locked = true if config.locked.nil?
      config.save!
    end

    GlobalConfig.clear_cache
  end

  def down; end
end
