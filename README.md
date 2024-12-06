# README

## Requirement
- Ruby 3.2.2
- Bundler
- Rails -v 8
- Postgresql

## Setting up
Copy file `dev.env` to .`env`and then fill the required variable for the database
```sh
DATABASE_HOSTNAME=
DATABASE_USERNAME=
DATABASE_PASSWORD=
```

Now we're are ready to run the application. But first we need to setup the development database. Run the command

```sh
rails db:setup
rails db:migrate
```
And then we can run the server with this command
```sh
rails s -b 127.0.0.1 -p 3000
```

you now can visit the application [here](http://127.0.0.1:3000/).

you can also visit the [Open API Documentation](http://127.0.0.1:3000/api-docs/index.html).

You can also add the sample data to the database by running this command:
```sh
rails db:seed
```

You can use user named "Lucy" as the test user