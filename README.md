# acts_as_account

[![Build Status](https://github.com/betterplace/acts_as_account/workflows/tests/badge.svg)](https://github.com/jaynetics/js_regex/actions)

## Theory

*ActsAsAccount* implements a "Double Entry Accounting" system for your
Rails-models.

It hooks into ActiveRecord and allows to add accounts to any model by
simply means of adding `has_account` to your model. Because the accounts
are connected via a `has_many` relation no migration to the account-holder
tables is needed.

We also hook into the ActionController request cycle to warn the developer
if a request has left uncommitted changes in the system.

## How to test

Run the cucumber features from the acs_as_account gem, just execute
* `rake features:create_database`
* `cucumber`

## How to release

You need to update the data in `VERSION` and Rakefile and run `rake` (because it uses Gemhadar).
`rake gem:push` will push the version to rubygems.

## Links

* Double Entry Accounting in a Relational Database: [http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html (archived)](https://web.archive.org/web/20080310200243/http://homepages.tcp.co.uk/~m-wigley/gc_wp_ded.html)

## Compatibility

Rails 4 is supported since version 3.1.0, Rails 7 since 3.2.2 .

## Credits

This gem was written for the payment backend of betterplace.org by [Thies C. Arntzen, "thieso2"](https://github.com/thieso2), [Norman Timmler, "unnu"](https://github.com/unnu) and others.

## Copyright

Copyright (c) 2010, 2022 [gut.org gAG](https://gut.org), released under the [Apache License v2.0](LICENSE).
