           ____________________________________________________
          |____________________________________________________|
          | __     __   ____   ___ ||  ____    ____     _  __  |
          ||  |__ |--|_| || |_|   |||_|**|*|__|+|+||___| ||  | |
          ||==|^^||--| |=||=| |=*=||| |~~|~|  |=|=|| | |~||==| |
          ||  |##||  | | || | |JRO|||-|  | |==|+|+||-|-|~||__| |
          ||__|__||__|_|_||_|_|___|||_|__|_|__|_|_||_|_|_||__|_|
          ||_______________________||__________________________|
          | _____________________  ||      __   __  _  __    _ |
          ||=|=|=|=|=|=|=|=|=|=|=| __..\/ |  |_|  ||#||==|  / /|
          || | | | | | | | | | | |/\ \  \\|++|=|  || ||==| / / |
          ||_|_|_|_|_|_|_|_|_|_|_/_/\_.___\__|_|__||_||__|/_/__|
          |____________________ /\~()/()~//\ __________________|
          | __   __    _  _     \_  (_ .  _/ _      _     _____|
          ||~~|_|..|__| || |_ _   \ //\\ /  |=|_  /) |___| | | |
          ||--|+|^^|==|1||2| | |__/\ __ /\__| |(\/((\ +|+|=|=|=|
          ||__|_|__|__|_||_|_| /  \ \  / /  \_|_\___/|_|_|_|_|_|
          |_________________ _/    \/\/\/    \_ /   /__________|
          | _____   _   __  |/      \../      \/   /   __   ___|
          ||_____|_| |_|##|_||   |   \/ __\       /=|_|++|_|-|||
          ||______||=|#|--| |\   \   o     \_____/  |~|  | | |||
          ||______||_|_|__|_|_\   \  o     | |_|_|__|_|__|_|_|||
          |_________ __________\___\_______|____________ ______|
          |__    _  /    ________     ______           /| _ _ _|
          |\ \  |=|/   //    /| //   /  /  / |        / ||%|%|%|
          | \/\ |*/  .//____// //   /__/__/ (_)      /  ||=|=|=|
        __|  \/\|/   /(____|/ //                    /  /||~|~|~|__
          |___\_/   /________//   ________         /  / ||_|_|_|
          |___ /   (|________/   |\_______\       /  /| |______|
              /                  \|________)     /  / | |

# Semcheck
### a command line tool to reconcile your domain model language
Think of Semcheck as your helpful automated reference librarian for schemas.

While building an API, you may want to check your potential domain models against existing schemas so that you can leverage established standards.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'semcheck'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install semcheck

To make use of a more extensive thesaurus, you will need to get an API key from [Big Huge Thesaurus](http://words.bighugelabs.com/) and have internet access. Then set:

    $ export BHT_API_KEY=yourkey

## Usage
Currently, you must have internet access to use this tool because there's not an easily available database of Schema.org's contents. But using RDF::Querys of a graph database of its schemas may be included in a future minor version.

    # restaurant is our search term
    bin/semcheck restaurant
    => Searching semweb resources for: ["restaurant"]
    => Possible schema matches: https://schema.org/Restaurant
    # if you want to make use of the extended thesaurus
    bin/semcheck -M machine
    => Searching semweb resources for: ["machine"]
    => Possible schema matches:
    => https://schema.org/Service

Using `-M` requires an extra API call but will often give you fewer results. Why? Because the synonyms it chooses are often more specifically related than the more general smattering you'll get from the local thesaurus (sometimes it won't even find a synonym, for even common words like "food").

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake rspec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## TODO
- integrate Swoogle
- local schema database

## Contributing
Bug reports and pull requests are welcome on GitHub at [mooreniemi/semcheck](https://github.com/mooreniemi/semcheck). This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

