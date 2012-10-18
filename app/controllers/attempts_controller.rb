class AttemptsController < ApplicationController
  # GET /attempts
  # GET /attempts.json
  def index
    @attempts =  Attempt.connection.select_all("select count(*) as times_attempted, p.title, a.outcome, p.id as problem_id from attempts  a join problems p on  p.id=a.problem_id  where user_id = #{current_user.id} group by problem_id")
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @attempts }
    end
  end

  # GET /attempts/1
  # GET /attempts/1.json
  def show
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Acceso Restringido' }
      format.json { render json: @attempt }
    end
  end

  # GET /attempts/new
  # GET /attempts/new.json
  def new
    @attempt = Attempt.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @attempt }
    end
  end

  # GET /attempts/1/edit
  def edit
    @attempt = Attempt.find(params[:id])
  end

  # POST /attempts
  # POST /attempts.json
  def create
    @problem = Problem.find(params[:problem_id])
    @attempt = @problem.attempts.new(params[:attempt])
    @attempt.user_id = current_user.id
    @attempt.language=params[:language]


    respond_to do |format|
      if @attempt.save
	@attempt.compile
	format.html { redirect_to @problem, notice: "Attempt was successfully created [#{@attempt.outcome}]" }
        format.json { render json: @problem, status: :created, location: @attempt }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /attempts/1
  # PUT /attempts/1.json
  def update
    @attempt = Attempt.find(params[:id])

    respond_to do |format|
      if @attempt.update_attributes(params[:attempt])
        format.html { redirect_to @attempt, notice: 'Attempt was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @attempt.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attempts/1
  # DELETE /attempts/1.json
  def destroy
    @attempt = Attempt.find(params[:id])
    problem = @attempt.problem
    @attempt.destroy

    respond_to do |format|
      format.html { redirect_to problem_path(problem) }
      format.json { head :no_content }
    end
  end
end
