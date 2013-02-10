# coderdojo-webapp

Ready to power the future of CoderDojoSF.

## Setup

Bootstrap the app.

```
script/bootstrap
```

Now configure .env with oauth app client id/secret.

```
script/server
```

View in your browser at [http://localhost:3000](http://localhost:3000)

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