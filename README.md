# todo_list_api
Created and sort tasks.

## SETUP

#### Using Docker

* setup makefile ( Skip this step if you have make on your ubuntu )
  * run `sudo apt-get update`
  * run `sudo apt-get install make`

* run `make setup`
  
  This will do the ff.
  * Create .env based on env.template.yml
  * Using entrypoint it will run db:migrate

* run `make start`

  This will just start the project so API can be accessible through localhost:3000


#### Without docker

* create a copy of env.template.yml and name it as .env
* run `rails db:migrate`
* run `rails start -b 0.0.0.0 -p 3000`


### Notes

I already added a postman collection here.
