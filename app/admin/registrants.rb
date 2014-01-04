ActiveAdmin.register Registrant do
  config.batch_actions = false
  actions :all

  index do
    id_column
    column :email
    column :created_at
    actions
  end
end
