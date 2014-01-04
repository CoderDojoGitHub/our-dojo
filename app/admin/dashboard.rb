ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content do
    render partial: "admin/lesson_builder"
  end

  sidebar :result do
    render partial: "admin/result"
  end
end
