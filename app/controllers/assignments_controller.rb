class AssignmentsController < ApplicationController
  def show
  end

  def index
    @assignments = current_user.assigned_problems || []
  end
end
