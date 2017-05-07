# Mass Invite

This library can be pluggled into a bigger application and solve the problem
with mass invitation for your users/customers. 

## Requirements
Ruby >= 2.4

## Installation

### RubyGems

Add this to the Gemfile:

    gem 'mass_invite'

or install it directly:

    gem install mass_invite

### Install from Git

Add the following in the Gemfile:

    gem 'mass_invite', :git => 'https://github.com/iCEAGE/mass_invite.git'


## Getting Started

Please follow the [installation](#installation) procedure and then run the following code:

```ruby
require 'mass_invite'

include MassInvite

customers = Customer.create_from_file
loc = Location.new(53.3393, -6.2576841)

customers.select{|c| c.location.distance_from(loc) < 100}.sort_by(&:user_id).each do |c|
  puts "#{c.name}/#{c.user_id}"
end
```

## Tests
To run the tests:
````
bundle exec rake
````

## License

Copyright (C) 2017 Hamed Ramezanian Nik

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with this program.  If not, see <http://www.gnu.org/licenses/>.
