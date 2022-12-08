# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

Author.create([{ name: 'Peter Parker' },
               { name: 'Otto Günther Octavius' }])

articles = Article.create([{ title: 'First article', status: 1, body: 'Some text for article', author_id: 1 },
                            { title: 'Second article', status: 1, body: 'Some more text for article', author_id: 2 },
                            { title: 'Three article', status: 0, body: 'Some more text for article', author_id: 1 },
                            { title: 'Four article', status: 0, body: 'Some more text for article', author_id: 1 },
                            { title: 'Five article', status: 0, body: 'Some more text for article', author_id: 1 }])

Comment.create([{ body: 'First comment', status: 0, author_id: 1, article_id: 1 },
                { body: 'Second comment', status: 0, author_id: 2, article_id: 2 },
                { body: 'Three comment', status: 1, author_id: 1, article_id: 1 },
                { body: 'Four comment', status: 1, author_id: 2, article_id: 2 },
                { body: 'Last comment', status: 0, author_id: 2, article_id: 2 }])

tags = Tag.create([{ name: 'new' },
                    { name: 'old' },
                    { name: 'it' },
                    { name: 'ruby' },
                    { name: 'rails' }])

articles.each do |article|
  article.tags << tags.sample
end
