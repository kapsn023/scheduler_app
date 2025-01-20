# README

## Software Versions
Ruby: 3.4.1

Rails: 8.0.1

PostgreSQL: 14.15

## Installation Instructions
```
git clone https://github.com/kapsn023/scheduler_app.git
cd scheduler_app
bundle install
rails db:create db:migrate db:seed 
rails server
```
This creates a server that is accessable [here](http://localhost:3000/).

This implementation is also reliant on PostgresSQL. It must be installed if not done so already.

## Rake Tasks
```
rake import:technicians
rake import:locations
rake import:work_orders
```
The Work Orders database is reliant on the technicians and locations databases.
One must import technicians and locations before one can import work_orders.

## Design Apporach

## Troubleshooting

## Future Improvements
