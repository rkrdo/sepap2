ActiveAdmin.register Attempt do
 filter :problem
 filter :user
 filter :group, as: :select, collection: Group.all.collect{|g| [g.name, g.id]}

 config.clear_action_items!

index do 
  column :user do |attempt|
    attempt.user.num
  end
  column :problem
  column :language
  column :outcome
  column :code
  column :created_at
end

end
