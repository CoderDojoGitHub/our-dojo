require Rails.root.join("test", "blueprints")

# Add lessons.

[
  {
    title: "Lesson 1",
    summary: "Description 1",
    repository: "lesson-1",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2015-12-05 13:00:00 -0800",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 2",
    summary: "Description 2",
    repository: "lesson-2",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-01-23 13:00:00 -0800",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 3",
    summary: "Description 3",
    repository: "lesson-3",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-03-19 13:00:00 -0700",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 4",
    summary: "Description 4",
    repository: "lesson-4",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-05-21 13:00:00 -0700",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 5",
    summary: "Description 5",
    repository: "lesson-5",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-07-23 13:00:00 -0700",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 6",
    summary: "Description 6",
    repository: "lesson-6",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-09-24 13:00:00 -0700",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  },
  {
    title: "Lesson 7",
    summary: "Description 7",
    repository: "lesson-7",
    author_github_username: "sijbrandij",
    events_attributes: [
      {
        "location" => "Camperoo 148 Townsend St San Francisco CA 94107",
        "date" => "2016-11-19 13:00:00 -0800",
        "length_in_hours" => 2,
        "teacher_github_username" => "sijbrandij"
      }
    ]
  }
].each {|attributes| Lesson.make!(attributes) }

EventImporter.new(Lesson.all).import
