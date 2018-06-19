# Kele

Kele is a Ruby gem that works with the Bloc student API. It allows messaging, checkpoint update, and submission features.

## Getting Started

To get started with this gem, you'll need only a few things. First, you need to get Ruby version 2.2.1 and have access to a Bloc account. This will be run from a terminal window.

### Installing

Once you have that, you should be able to get a copy of the repository by forking it.

The project will be run using the interactive Ruby shell.

```
$ irb
```

Within the IRB, you should include the gem and then enter the user information as so:

```
>> require './lib/kele'
=> true
>> Kele.new("jane@gmail.com", "abc123")
```

To get your various kinds of information such as mentor ID and checkpoint IDs, use this command:

```
>> kele_client.get_me
```

Some of the commands you will use will include:

```
>> kele_client.get_mentor_availability(mentor_id) # gets schedule of mentor using their ID
>> kele_client.get_roadmap(chain_id) # get list of all checkpoints
>> kele_client.get_checkpoint(checkpoint_id) # view specific checkpoint by ID
>> kele_client.get_messages(1) # returns the first page of message threads
>> kele_client.get_messages # returns all message threads
>> kele_client.create_message(recipient,title,body,token_id) # send message to user via their ID
```

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - The programming language used

## Acknowledgments

* Big thanks to my mentor for helping me through the tough times.
