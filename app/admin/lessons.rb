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

ActiveAdmin.register_page "Lesson Generator" do
  content do
    render partial: "admin/lesson_builder"
  end

  sidebar :result do
    render partial: "admin/result"
  end
end
