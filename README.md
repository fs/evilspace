# Evilspace

Enforce trailing spaces and tabs removing from your rails application codebase.

![Tabs, spaces, both](http://i.imgur.com/pVzVU.png)

Show HTTP 500 page with warning about evil spaces instead application page.

## Installation

Add this line to your rails application's Gemfile:
``` rb
    gem 'evilspace', git: 'git://github.com/fs/evilspace.git'
```
And this to `config/environments/development.rb`:
``` rb
    config.middleware.use 'Evilspace::Middleware'
    # or
    config.middleware.use Evilspace::Middleware, ['app', 'lib']
```
## Usage

1. Add tabs or trailing spaces to any ruby file under app directory
2. Open any page of your application in browser
3. Look at waring page instead application page
4. Fix evil spaces
5. PROFIT!!!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
