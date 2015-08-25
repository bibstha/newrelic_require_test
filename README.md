# NewRelicRequireTest

1. Create a mysql db named `makara_newrelic_test`
2. Run `sidekiq -r ./test.rb` and everything should run fine.
3. Run `sidekiq -r ./test.rb bug` and after 4 or 5 insert, it would fail with
   connection pool issue.
