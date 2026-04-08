require 'administrate/field/base'

class CeAccountFeaturesField < Administrate::Field::Base
  def feature_rows
    features.sort_by { |feature_name, _enabled| display_names[feature_name] || feature_name }
            .map do |feature_name, enabled|
      [
        feature_name,
        display_names[feature_name] || feature_name.humanize,
        enabled
      ]
    end
  end

  private

  def features
    data.to_h
  end

  def display_names
    @display_names ||= Featurable::FEATURE_LIST.each_with_object({}) do |feature, labels|
      labels[feature['name']] = feature['display_name']
    end
  end
end
