require "machinist/active_record"
require "faker"

Lesson.blueprint do
  title { "Lesson #{sn}" }
  summary { "Learn crazy awesome #{sn} when you use #{sn}."}
  repository { "lesson-#{sn}" }
  author_github_username { "jonmagic" }
  events_attributes {
    [
      {
        "location" => "GitHub 548 4th St San Francisco CA 94107",
        "date" => 1.week.from_now.to_s,
        "length_in_hours" => 2,
        "teacher_github_username" => "jonmagic"
      }
    ]
  }
end

Event.blueprint do
  lesson { Lesson.make! }
  location { "GitHub 548 4th St San Francisco CA 94107" }
  start_time { 1.weeks.from_now }
  teacher_github_username { "user-#{sn}" }
end
