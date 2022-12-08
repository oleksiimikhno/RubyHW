# Blog API on RoR with postgresql.

## Setup

* Install bundler gems `bundle install`

* Rename configuration database file `database.example.yml` to `database.yml` in folder `/blog-RoR-api/config/`

* Change your database user in file `database.yml`
  - `username: your_username`
  - `password: your_password`

* Database initialization `bundle exec rails db:create`

* Database migrate execute `bundle exec rails db:migrate`

* Database seeds execute `bundle exec rails db:seed`

* Start server `bundle exec rails s`

* Open API server http://127.0.0.1:3000/api/v1/articles

## Add new Article to API

* Open RoR console `bundle exec rails c`

* Create Article `article = Article.new(title: 'New Article title', body: 'Article body text', author_id: 1)`

* Save articles `article.save`

* Look all articles `Article.all`

## Looks comments in article

* Route `/api/v1/articles/1` see all comments in article :id

* Route `/api/v1/articles/1/published` see all published comments in article

* Route `/api/v1/articles/1/unpublished` see all unpublished comments in article

* Route with params `/api/v1/articles/1?status=published` see article and all published comments

* Route with params `/api/v1/articles/1?status=unpublished` see article and all unpublished comments

* Route with params `/api/v1/articles/1/comments?status=published` see only published comments in article

* Route with params `/api/v1/articles/1/comments?status=unpublished` see only unpublished comments in article
  ### Filter last comments with limit params 

  - Route with params `last=10` if you want see last 10 comments in article

## Filter articles by tag

* Route `/api/v1/articles?tag=new` see all articles with tag `new`

## Add new tag in article

* Route `/api/v1/articles?/1/add-tag?name=new` if tag exit in tag_table

## Create/destroy likes
  `use POST method`
* Route to create new like `/api/v1/likes?like[likeable_id]=2&like[likeable_type]=Comment` where `likeable_id` is comment_id
  `use DELETE method`
* Route to destroy like `/api/v1/likes/1`

## Looks all comments

* Route `/api/v1/comments` see all comments

* Route `/api/v1/comments/published` see all published comments

* Route `/api/v1/comments/unpublished` see all unpublished comments

* Route with params `/api/v1/comments?status=published` see all published comments

* Route with params `/api/v1/comments?status=unpublished` see all unpublished comments
  ### Filter last comments with limit params 

  - Route with params `last=10` if you want see last 10 comments

## Switch status comment
  `use GET method`
* Route `/api/v1/comments/1/switch` to switch comment published/unpublished 

## Create new comments with params
  `use POST method`
* Create new comment `/api/v1/comments?comment[body]=Create new comment&comment[status]=published&comment[article_id]=1&comment[author_id]=1`

  - where `comment[body]=Create new comment` body comment
  - where `comment[status]=published` status comment
  - where `comment[article_id]=1` id of the article to which we added
  - where `comment[author_id]=1` id of the author

## Init and start React server

* `cd blog` and start `npm i` to install npm modules

* start React server `PORT=3001 npm run start`