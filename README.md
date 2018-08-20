# TASK


Backend project

Using only the https://api.magicthegathering.io/v1/cards endpoint from the Magic the Gathering API and without using any query parameters for filtering, create a command-line tool that:

    1) Returns a list of Cards grouped by set.
    2) Returns a list of Cards grouped by set and then each set grouped by rarity.
    3) Returns a list of cards from the Khans of Tarkir (KTK) that ONLY have the colours red AND blue (same results as https://api.magicthegathering.io/v1/cards?set=KTK&colors=Red,Blue)

Environment

    You can use any one of the following programming languages: Ruby, Elixir, JavaScript, Crystal, Python, Go.

Limitations

    You are not allowed to use a third-party library that wraps the MTG API.
    You can only use the https://api.magicthegathering.io/v1/cards endpoint for fetching all the cards. You can't use query parameters to filter the cards.

What we look for

    Readability. Simplicity.
    Separation of Concerns.
    Avoid unnecessary abstractions.
    Great naming. We know naming things is one of the two hardest problems in programming, so try to not make your solution too cryptic or too clever.
    Adherence to your language/framework conventions. No need to get too creative._
    Comprehensive testing. TDD is dead? No problem. Just make sure your bases are covered.
    Take your time, measure twice and cut once. Let us know roughly how much time you've spent.

Bonus points for...

    Using only the programming language's standard library.
    Parallelising the retrieval of all the Cards to speed up things.
    Respecting the API's Rate Limiting facilities.


## My solution

#### This task was coded using Ruby 2.5.1.

You should have Ruby and bundler to run the main program and its specs. Follow these steps to install and run

* clone this project:  ```git clone git@github.com:martincabrera/ruby-cli-project.git```
* Run ```bunde install``` to install gems from Gemfile
* Run ```bundle exec rspec``` to run specs
* Run ```rubocop``` to run this static code analyzer

## Usage

* Run ```ruby main.rb``` to learn how to use this CLI

### Program options:
``` 
option                  | command                       |  Description
-----------------------------------------------------------------------------------------
-h, --help              |  ruby main.rb --help          | Show help on how to use this CLI
-v, --version           |  ruby main.rb --version       | Show version
-o, --one               |  ruby main.rb --one           | Returns a list of cards grouped by set
-t, --two               |  ruby main.rb --two           | Returns a list of Cards grouped by set, each set grouped by rarity
-r, --three             |  ruby main.rb --three         | Returns a list of cards from KTK set that ONLY have the colors red AND blue
-f, --four              |  ruby main.rb --four          | Returns a list of cards from KTK set that have the colors red AND blue among others
-d, --delete_cache      |  ruby main.rb --delete_cache  | Deletes Cached Cards in ./tmp directory
```

Note: Point 3 of this task is not clear: it starts by saying that the program must return "a list of cards from the Khans of Tarkir (KTK) that ONLY have the colours red AND blue" but then points to an Endpoint (https://api.magicthegathering.io/v1/cards?set=KTK&colors=Red,Blue) which actually returns a list of cards from the Khans of Tarkir (KTK) that have the colours red AND blue but **not** exclusively. I have implemented both options (see ```ruby main.rb --three``` and ```ruby main.rb --four```) to avoid this misunderstanding.