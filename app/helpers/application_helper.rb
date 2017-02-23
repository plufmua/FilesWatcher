module ApplicationHelper
  def bootstrap_flashes(flash_type)
    case flash_type
      when 'success'
        'alert-success'
      when 'error'
        'alert-danger'
      when 'alert'
        'alert-warning'
      else
        flash_type.to_s
    end
  end
end
