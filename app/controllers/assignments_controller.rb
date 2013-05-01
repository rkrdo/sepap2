class AssignmentsController < ApplicationController
  def show
  end

  def index
    @assignments = current_user.assignments
  end
end
