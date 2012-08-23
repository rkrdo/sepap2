ActiveAdmin.register Group do
  form(:html => { :multipart => true }) do |f|
    f.inputs "Details" do
      f.input :name
      f.input :period, as: :select
      f.input :subject
      f.input :members, as: :file
    end
    f.buttons
  end
end
