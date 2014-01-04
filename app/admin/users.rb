ActiveAdmin.register User do
  config.batch_actions = false
  actions :index

  index do
    column :id
    column :name
    column :email
    column :github_identifier
    column :created_at
  end
end
