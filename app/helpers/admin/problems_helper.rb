module Admin::ProblemsHelper

  def humanized_language(locale)
    if locale == "es"
      return "Spanish"
    else
      return "English"
    end
  end

  def activate_problem(problem)
    if problem.active?
      link_to "Desactivate", admin_problem_toggle_active_path(problem), method: :put, class: "button tiny"
    else
      link_to "Activate", admin_problem_toggle_active_path(problem), method: :put, class: "button tiny"
    end
  end

end
