ActiveAdmin.register User do
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :teacher, :label => "Teacher"
    end
    f.buttons
  end

  show do |ad|
    attributes_table do
        row :name
        row :num
        row :email
        row :teacher
      end
  end

  index do
    column :email
    column :reset_password_sent_at
    column :current_sign_in_at
    column :last_sign_in_at
    column :current_sign_in_ip
    column :created_at
    column :updated_at
    column :teacher
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
