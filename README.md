# README
### Components
  - contracts, they act as schema validation and all partners have their own contract. We will detect which transformation best to used to transform payload/schema to hometime standard reservation data based on selected contract
  - transformers, enable us to compose different payload from different partners to hometime schema
  - PartnerReservationIntegrator, as the brain to choose a suitable contract to use, call relevant transformer and store data to persistent storage

Postman collection https://documenter.getpostman.com/view/13585458/UVeCP87U

How to run this application:

* Ruby version
  - ruby 2.6.5
  - rails 6.0.1

* Configuration
go to directory project and run
```
$ bundle install
```

* Database creation
run
```
$ rails db:reset
```

* Database initialization
```
$ rails db:migrate
```

* How to run the test suite
```
$ bundle exec rspec
```