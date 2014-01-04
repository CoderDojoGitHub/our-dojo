ActiveAdmin.register Registration do
  config.batch_actions = false
  actions :all

  index do
    id_column
    column :registrant
    column :event
    column :created_at
    actions
  end
end
