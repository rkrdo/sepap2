module Admin::ProblemsHelper
  
  def humanized_language(locale)
    if locale == "es"
      return "Spanish"
    else
      return "English"
    end
  end

end
