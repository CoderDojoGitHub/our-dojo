require Rails.root.join("test", "blueprints")

# Add lessons.

[
  {
    title: "Data Types",
    summary: "We will learn about String, Array, and Hash.",
    repository: "data-types",
    author_github_username: "mikefowler",
    events_attributes: [
      {
        "location" => "GitHub 88 Colin P Kelly Jr St San Francisco CA 94107",
        "date" => 1.week.from_now.to_s,
        "length_in_hours" => 2,
        "teacher_github_username" => "mikefowler"
      }
    ]
  },
  {
    title: "First Program",
    summary: "We will learn how to write our first program.",
    repository: "first-program",
    author_github_username: "broccolini",
    events_attributes: [
      {
        "location" => "GitHub 88 Colin P Kelly Jr St San Francisco CA 94107",
        "date" => 1.week.ago.to_s,
        "length_in_hours" => 2,
        "teacher_github_username" => "broccolini"
      }
    ]
  },
  {
    title: "Web Development",
    summary: "We will learn how to tell a story using HTML and CSS.",
    repository: "web-development",
    author_github_username: "jonmagic",
    events_attributes: [
      {
        "location" => "GitHub 88 Colin P Kelly Jr St San Francisco CA 94107",
        "date" => 2.week.from_now.to_s,
        "length_in_hours" => 2,
        "teacher_github_username" => "jonmagic"
      }
    ]
  }
].each {|attributes| Lesson.make!(attributes) }

EventImporter.new(Lesson.all).import
