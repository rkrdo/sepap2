module AttemptsHelper
  def class_for_status(status)
    case 
      when status == "accept"
        return "icon-ok-sign icon-2x icono-accept"
      when status == "timeout"
        return "icon-time icon-2x icono-timeout"
      when status == "fail"
        return "icon-remove-sign icon-2x icono-fail"
      when status == "compile_error"
        return "icon-exclamation-sign icon-2x icono-uncompile"
      when status == "compiling"
        return "icon-cogs icon-2x icono-compiling"
      else
        return ""
    end
  end

end
