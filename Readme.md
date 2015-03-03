Dragonfish
==========
Dragonfish is a proof of concept dark web search / indexer.

Getting Started
---------------
1. Run `bundle install`
2. Install / start redis (sidekiq won't work well)
3. Install / configure tor.  BE CAREFUL.
4. run `bundle exec rake:db:seed` (this will seed your crawler wtih some wikis)
5. Start sidekiq by running `sidekiq`
