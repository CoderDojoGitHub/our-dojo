require "machinist/active_record"
require "faker"

Lesson.blueprint do
  title { "Lesson #{sn}" }
  summary { "Learn crazy awesome #{sn} when you use #{sn}."}
  repository { "lesson-#{sn}" }
end

Event.blueprint do
  title { "Event #{sn}" }
  start_time { 3.weeks.from_now }
end
