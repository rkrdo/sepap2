module AttemptsHelper
  def class_for_status(status)
    case status
    when :accept
      return "icon-ok-sign icon-2x icono-accept"
    when :timeout
      return "icon-time icon-2x icono-timeout"
    when :fail
      return "icon-remove-sign icon-2x icono-fail"
    when :uncompile
      return "icon-exclamation-sign icon-2x icono-uncompile"
    when :compiling
      return "icon-cogs icon-2x icono-compiling"
    else
      return ""
    end
  end
end
