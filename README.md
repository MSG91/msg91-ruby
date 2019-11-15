# MSG91

Send your next message via MSG91 in ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'msg91', git: 'git://github.com/MSG91/msg91-ruby.git'
```

And then execute:

    $ bundle

## Usage

Initialize the API client with your auth key.

```ruby
api_client = MSG91::Client.new('your_auth_key')
```

#### Basics

- Check route balance
```ruby
api_client.check_balance(Message::ROUTES::PROMOTIONAL) #=> 129
```
- Check if authkey is valid
```ruby
api_client.valid? #=> true
```

#### Send messages
```ruby
message = api_client.messages.new(phones: [9876543210, 9548741230], sender: 'TESTER')
message.content = 'The quick brown fox jumps over the lazy dog'
message.route = Message::ROUTES::PROMOTIONAL

message.send
```

#### Manage Phonebook

##### Create Group
```ruby
group = api_client.phonebook.groups.new('new_group')
group.save

# OR

api_client.phonebook.groups.create('new_group')
```

##### List Groups
```ruby
api_client.phonebook.groups.list
```

##### Delete Group
```ruby
group.delete

# OR

api_client.phonebook.delete_group(group_id)
```

##### Create Contact
```ruby
contact = group.contacts.new(9876543210)
contact.name('Test User')
contact.save

# OR

group.contacts.create(phone: 9876543210, name: 'Test User')
```

##### Update Contact
```ruby
contact.phone = 9548741230
contact.save

# OR

api_client.phonebook.update_contact(id, phone: 9548741230, name: 'Another User')
```

##### Delete Contact
```ruby
contact.delete

# OR

api_client.phonebook.delete_contact(contact_id)
```

##### List Contacts
```ruby
group.contacts.list
```

#### Manage Resellers

##### Add Client
```ruby
client = api_client.resellers.clients.new
client.full_name = 'My new client'
client.user_mobile_number = 9876543210
client.save

# OR

client = api_client.resellers.clients.create(full_name: 'My new client', ...)
```

##### List Clients
```ruby
client.resellers.clients.list
```

##### Update Client Balance
```ruby
client.debit(sms: 200, price: 0.8, route: Message::ROUTES::PROMOTIONAL, description: 'Test message')
client.credit(sms: 200, price: 0.75, route: Message::ROUTES::PROMOTIONAL, description: 'Test message')

# OR

api_client.resellers.update_client_balance(client_id, sms: 200, price: 0.8, route: Message::ROUTES::PROMOTIONAL, direction: Reseller::TRANSACTIONS::DEBIT, description: 'Test message')
api_client.resellers.update_client_balance(client_id, sms: 200, price: 0.75, route: Message::ROUTES::PROMOTIONAL, direction: Reseller::TRANSACTIONS::CREDIT, description: 'Test message')
```

##### Change Client Password
```ruby
client.change_password('new_password')
# OR
api_client.resellers.change_client_password(client_username, new_password: 'new_password')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/MSG91/msg91-ruby/issues.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

