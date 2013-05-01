class Teacher::ProblemsController < Teacher::BaseController
  # GET /teacher/problems
  # GET /teacher/problems.json
  def index
    @problems = Problem.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problems }
    end
  end

  # GET /teacher/problems/1
  # GET /teacher/problems/1.json
  def show
    @problem = Problem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem }
    end
  end

  # GET /teacher/problems/new
  # GET /teacher/problems/new.json
  def new
    @problem = Problem.new
    @problem.titles.build({:locale => "es"})
    @problem.titles.build({:locale => "en"})
    @problem.descriptions.build({:locale => "es"})
    @problem.descriptions.build({:locale => "en"})
    @problem.cases.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem }
    end
  end

  # POST /teacher/problems
  # POST /teacher/problems.json
  def create
    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        format.html { redirect_to [:admin, @problem], notice: 'Problem was successfully created.' }
        format.json { render json: @problem, status: :created, location: @problem }
      else
        format.html { render action: "new" }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

end
