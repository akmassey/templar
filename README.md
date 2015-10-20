# Templar

Templar is a project templating engine.  If you find yourself regularly
creating new projects by `cp -r old-project new-project`, then this may be
the tool for you.  It is great for simple one-off test projects where you just
need to setup a bare bones program structure, but it’s also great as a tool to
create LaTeX projects from templates.

## Installation

Add this line to your application's Gemfile:

    gem 'templar'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install templar

## Usage

Getting a new article started could be as simple as:

    templar -t article my-latest-article

You can specify your default attributes in a templar config file like this:

    --- !Templar
    author: True Grit
    department: Department of Information Systems
    affiliation: University of Maryland, Baltimore County
    city: Baltimore, MD, USA
    email: example@umbc.edu
    webpage: http://www.umbc.edu

These attributes would then be available to all templates used by Templar.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Future Development

It would be great to be able to provide a file to replace one of the files
provided in the template at run time.  For example, doing something like this:

    templar -t latex_article --replace bib/bibliography.bib=$HOME/Documents/my-pubs.bib

...should be possible.  I’m not sure if that’s the sort of syntax I like, but
something along those lines would be nice.
