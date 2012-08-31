ActiveAdmin.register Group do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :period, as: :select
      f.input :subject
      f.input :members, as: :text
    end
    f.buttons
  end

  index do 
    column :name
    column :period
    column :subject
    column :members do |g|
      if g.users.present?
        link_to "Miembros", view_members_admin_group_path(g)
      else
        '-'
      end
    end
    default_actions
  end

  member_action :view_members do
    @group = Group.find(params[:id])
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
  end
end
