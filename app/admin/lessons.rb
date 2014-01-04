ActiveAdmin.register Lesson do
  config.batch_actions = false
  actions :all

  index do
    id_column
    column :title
    column :author_github_username
    actions
  end
end
