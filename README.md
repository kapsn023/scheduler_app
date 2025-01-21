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
As I only had limited time, I had to be careful with how I approached the design of this project and how I allotted my time. I had three days to work, so I broke the project down into three parts: databases/backend, HTML/CSS layouts, and JavaScript functionality. I knew that I needed to test each component thoroughly and make sure that each of them was working before building upon them. 

I decided to use PostgreSQL, because it is open-source and has access to great features.

## Troubleshooting
Though the project went smoothly, it still required some troubleshooting. The first instance of this was making the rake tasks idempotent. I originally gravitated towards using find_or_create_by(), except this would not allow users to update entries in the database after they had been made. After exploring my options, I decided instead to use an if-else statement that tries to find and modify an existing entry and only resorts to creating a new one if the corresponding id is not already in the system.

The next instance revolved around how I wanted to display information. When designing the chart, I ran into the problem of not being able to assume certain active hours for the technicians. To solve this, I thought of two solutions; I could either determine the range of active hours dynamically or I could include all hours of the day in the chart. I went with the second option as I thought the first would introduce needless complexity. This created another problem; the bulk of the useful information would be lower on the chart and the user would be unable to see the column labels after scrolling down. I solved this by simply having the labels of each column stay fixed at the top so as always to be visible.

## Future Improvements
With any project, there is naturally plenty of room for improvements. I think the two most notable shortcomings stem from how the available time pop-up works. Firstly, the pop-up would ideally be less intrusive than the alert. The alert stops everything and requires the user to click a button to get out of it. This is unfortunate, given how often the user is likely to use this functionality. Perhaps a better solution would be to have a pop-up appear next to the mouse and clicking anywhere else would get rid of it. 

The other notable shortcoming is a result of how the available time is calculated. Currently, when the user clicks on a slot, the program looks for availability at the start of the time slot. This works well in the majority of instances, but if a user were to click the bottom of a time slot that is partially filled, the program would assume that the user meant the start of the time slot and could give the user an unintuitive answer. This would ideally be improved by more accurately tracking the position of the click and accounting for these circumstances.

More improvements could include optimizations of the available time calculations, dynamic calculations of technicians’ active hours, and allowing users to directly add work orders to the database from the website.
