ActiveAdmin.register EventSubscriber do
  config.batch_actions = false
  actions :all

  index do
    selectable_column
    column :email
    column :event
    actions
  end
end
