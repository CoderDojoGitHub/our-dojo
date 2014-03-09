ActiveAdmin.register Event do
  config.batch_actions = false
  actions :all

  index do
    id_column
    column :lesson
    column :teacher_github_username
    column :start_time
    column 'Registered Students' do |event|
      event.total_students
    end
    column :class_size
    actions
  end
end
