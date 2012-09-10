module ProblemsHelper
  def highlight(code)
    CodeRay.scan("ruby", "puts 'Hello world!'").div(css: :class)
  end
end
