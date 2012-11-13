ActiveAdmin.register Group do
  # controller.authorize_resource 
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :period, as: :select, collection: Group::PERIODS
      f.input :subject
    end
    f.inputs "Members"do
      f.input :members, as: :text
    end
    if !f.object.new_record?
      f.has_many :enrollments do |enrollment|
        enrollment.inputs "#{enrollment.object.user.try(:num)}" do
          enrollment.input :_destroy, :as=>:boolean, :required => false, :label=>'Remove'
        end
      end
    end
    f.buttons
  end

  index do 
    column :name
    column :period
    column :subject
    default_actions
  end

  show do
    attributes_table do
        row :name
        row :subject
        row :period
    end
    panel "Members" do
      table_for group.enrollments do
        column "Num" do |enrollment|
          link_to enrollment.user.num, admin_user_path(enrollment.user)
        end
        column "First Name" do |enrollment|
          enrollment.user.try(:name)
        end
        column "Last Name" do |enrollment|
          enrollment.user.try(:lastname)
        end
      end
    end
    panel "Revision Per Problem" do
      render "problem_revision", locals: {group: group}
    end
  end

  controller do

    def create
      @group = Group.new(params[:group])
      respond_to do |format|
        if @group.save
          errors = @group.populate_group
          flash[:errors] = "The following student ids are not valid: #{errors}" unless errors.blank?
          format.html { redirect_to admin_groups_path, notice: 'Group was successfully created.' }
        else
          format.html { render action: "new" }
        end
      end
    end

    def update
      @group = Group.find(params[:id])
      @group.members = params[:group][:members]
      @group.enrollments_attributes = params[:group][:enrollments_attributes]
      respond_to do |format|
        if @group.save
            errors = @group.populate_group
            flash[:errors] = "The following student ids are not valid: #{errors}" unless errors.blank?
            format.html { redirect_to admin_group_path(@group), notice: 'Group was successfully updated.' }
        else
          format.html {render action: "index"}
        end
      end
    end

    def show
      @group = Group.find(params[:id])
    end
  end
end
