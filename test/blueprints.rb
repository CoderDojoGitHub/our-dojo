require "machinist/active_record"
require "faker"

Event.blueprint do
  title { "Event #{sn}" }
  start_time { 3.weeks.from_now }
end
