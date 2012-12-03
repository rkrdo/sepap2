ActiveAdmin.register User do
  controller.authorize_resource
  form do |f|
    f.inputs "User Details" do
      if f.object.new_record?
        f.input :email
        f.input :password
        f.input :password_confirmation
      else 
        f.input :teacher, :label => "Do you wish to give teacher power to #{f.object.name + f.object.lastname rescue f.object.num}"
      end
    end
    f.buttons
  end

  show do |ad|
    panel "User" do
      attributes_table do
          row :name
          row :num
          row :email
        end
    end
    panel "Attempts" do
      table_for(user.attempts) do |t|
        t.column :problem
        t.column :outcome
        t.column :created_at
      end
    end
  end

  index do
    column :email
    column :name
    column :lastname
    column :current_sign_in_ip
    column :last_sign_in_at
    column :created_at
    column :teacher
    default_actions
  end

  create_or_edit = Proc.new {
    @user            = User.find_or_create_by_id(params[:id])
    @user.teacher = params[:user][:teacher]
    @user.attributes = params[:user].delete_if do |k, v|
      (k == "teacher") ||
      (["password", "password_confirmation"].include?(k) && v.empty? && !@user.new_record?)
    end
    if @user.save
      redirect_to :action => :show, :id => @user.id
    else
      render active_admin_template((@user.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit
end
