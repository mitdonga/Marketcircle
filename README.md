
# Marketcircle rails-assessment

https://github.com/mitdonga/Marketcircle/assets/105274492/a7aa690c-bf7c-4364-adc7-1a59da51b683

This Rails 7 app has two models User and Info, offering CRUD APIs and a UI driven by Hotwire with turbo-frame and turbo-streams.

Database Schema

Users table has columns
- name : string


Infos table has columns
- title      : string
- email      : string
- age        : integer
- phone      : string
- user_id    : foreign_key


Defined Associations

- User has_one Info
- Info belongs_to User



## Run Locally


First, Install ruby 3.2.2 using rbenv or rvm

```bash
  rbenv install 3.2.2
```

Install dependencies

```bash
  bundle install
```

Setup database

```bash
  rails db:create
  rails db:migrate
  rails db:seed
```


Start the Rails Server

```bash
  rails server
```

By default, it will run on http://localhost:3000


## API Reference

#### Users APIs

```bash
  GET     /users.json
  GET     /users/${user_id}.json
  POST    /users.json
  PUT     /users/${user_id}.json
  DELETE  /users/${user_id}.json
```

#### User Info APIs

```bash
  GET     /infos.json
  GET     /infos/${info_id}.json
  POST    /infos.json
  PUT     /infos/${info_id}.json
  DELETE  /infos/${info_id}.json
```

## Postman API collection

```bash
https://api.postman.com/collections/21655182-7eebfb17-025d-4d19-a593-a4640a2e830e?access_key=PMAT-01HQ41D9BNR8P6WZSSQN74CFM4
```
