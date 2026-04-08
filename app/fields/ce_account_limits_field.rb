require 'administrate/field/base'

class CeAccountLimitsField < Administrate::Field::Base
  LIMIT_LABELS = {
    'agents' => 'Agents',
    'inboxes' => 'Inboxes'
  }.freeze

  def limit_rows
    Account.super_admin_editable_limit_keys.map do |limit_name|
      [
        limit_name,
        LIMIT_LABELS.fetch(limit_name, limit_name.humanize),
        value_for(limit_name)
      ]
    end
  end

  private

  def value_for(limit_name)
    data.to_h[limit_name] || data.to_h[limit_name.to_sym]
  end
end
