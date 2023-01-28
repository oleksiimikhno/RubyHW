# Store

## Create db
  - Create database `rails db:create`
  - Run migration `rails db:migration`
  - Install seeds `rails db:seed`
## User login
  - default user login/password `admin@example.com password`
## Admin dashboard
  - Link `loadlhost:3000/admin`
  - Default admin login/password `admin@example.com password`

## Active storage 
 - `brew install imagemagick` for active storage in macos
### Sidekiq configuration
  - `brew install redis` install if not have redis
  - `brew services start redis` add to services 
  - `bundle exec sidekiq` start sidekiq
  - `http://localhost:3000/admin/sidekiq/` open local web dashboard
