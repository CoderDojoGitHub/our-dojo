CoderDojo Event App
===================

An event website focused on delivering lesson information and event signup to potential students. The app will be backed by public repositories in a GitHub organization (or user) that each have a lesson.json file containing lesson information including the lesson title, summary, location, event date and time, class length, and teacher.

Example lesson.json:

```json
{
  title: "Animations in JavaScript",
  summary: "Build animations in the web browser using javascript and the D3.js library.",
  events: [
    {
      location: "GitHub 548 4th St San Francisco CA 94107",
      date: "Sat Apr 20 2013 10:00:00 GMT-0700 (PDT)",
      length_in_hours: 2,
      teacher_github_username: "jonmagic"
    }
  ]
}
```

## Getting Started

Make sure you are using Ruby 1.9.3. Then you can clone the repository and run script/bootstrap:

```
script/bootstrap
```

Now set GITHUB_ORGANIZATION in .env to the GitHub organization the app should look at for lesson repositories. Make sure to uncomment GITHUB_ORGANIZATION as well.

```
=======
# Set environment variables in here.
#
# For development see https://github.com/organizations/CoderDojoSF/settings/applications/34817
#
# Example:
#
# GITHUB_CLIENT_ID=1234567890
# GITHUB_CLIENT_SECRET=1234567890
# GITHUB_TEAM_ID=1234567890
GITHUB_ORGANIZATION=coderdojosf
```

Fire up the web server.

```
script/server
```

View in your browser at [http://localhost:3000](http://localhost:3000)

## Testing

We use guard to watch the project and automatically run tests when files change.

```bash
guard
```

Once you start guard press enter to run all of the tests.

## Deploying

Add the heroku git repository to the project.

```
git remote add heroku git@heroku.com:coderdojosf.git
```

Push to heroku.

```
git push heroku master
```

Or you can push a branch.

```
git push heroku new-cool-feature-branch:master
```

View in your browser [http://coderdojosf.herokuapp.com/](http://coderdojosf.herokuapp.com/)