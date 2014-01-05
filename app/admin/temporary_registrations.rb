ActiveAdmin.register TemporaryRegistration do
  config.batch_actions = false
  actions :all

  index do
    id_column
    column :registrant
    column :event
    column :created_at
    actions
  end

  action_item :only => :show do
    link_to 'Confirm Registration', confirm_path(temporary_registration.reference_token)
  end
end
