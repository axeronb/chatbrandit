class SwitchBrandingAssetsToGobranditPngs < ActiveRecord::Migration[7.0]
  BRANDING_ASSET_CONFIGS = {
    'LOGO_THUMBNAIL' => '/brand-assets/gobrandit-square.png',
    'LOGO' => '/brand-assets/gobrandit-navbar.png',
    'LOGO_DARK' => '/brand-assets/gobrandit-navbar.png'
  }.freeze

  def up
    BRANDING_ASSET_CONFIGS.each do |name, value|
      config = InstallationConfig.find_or_initialize_by(name: name)
      config.value = value
      config.locked = true if config.locked.nil?
      config.save!
    end

    GlobalConfig.clear_cache
  end

  def down; end
end
