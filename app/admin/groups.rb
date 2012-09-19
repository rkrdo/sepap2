ActiveAdmin.register Group do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :period, as: :select
      f.input :subject
    end
    f.inputs "Members"do
      f.input :members, as: :text
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
          enrollment.user.num
        end
        column "First Name" do |enrollment|
          enrollment.user.name
        end
        column "Last Name" do |enrollment|
          enrollment.user.lastname
        end
      end
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
      @group.members = "A00192955"
      respond_to do |format|
        if @group.save
            errors = @group.populate_group
            flash[:errors] = "The following student ids are not valid: #{errors}" unless errors.blank?
            format.html { redirect_to admin_group_path(@group), notice: 'Group was successfully updated.' }
        else
          format.html { render action: "index" }
        end
      end
    end
  end
end
