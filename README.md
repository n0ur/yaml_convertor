# YamlConvertor

Ruby gem that converts a YAML hash structure to a simple hash consisting of key:value only, and vice versa

a YAML hash structure could look like this:
````
{"fruit"=> {
    "lemon"=>"yellow", 
    "apple"=>{ "red_apples"=>"red" }
  }
}
````
The resulting simple key:value hash looks like this:
````
{"fruit.lemon"=>"yellow", "fruit.apple.red_apples"=>"red"}
````
This works the other way around, too: if you had the simple hash; you can reconstruct the YAML hash structure.

## Installation

Add this line to your application's Gemfile:
````
    gem 'yaml_convertor'
````
And then execute:
````
    $ bundle
````
Or install it yourself as:
````
    $ gem install yaml_convertor
````
## Usage

There are two methods you can use:
- **flattener** converts the structured nested YAML hash to a simple key:value

````
YamlConvertor.flattener(yml_hash)
````

- **builder** rebuilds the simple hash to a nested YAML structure

````
YamlConvertor.builder(flat_hash)
````

## Example

Let's assume we have a YAML file called **file.yml**:
````
en:
  errors:
    messages:
      not_locked: "was not locked"
      not_saved:
        other: "other error"
  devise:
    failure:
      already_authenticated: 'You are already signed in.'
    sessions:
      signed_in: 'Signed in successfully.'
````
We open this file using Psych (Ruby's YAML parser), and it will return a nested YAML hash structure
````ruby
yml_hash = Psych.load_file('file.yml')
````
yml_hash looks like this:
````
{"en"=>{
  "errors"=>{
    "messages"=>{
      "not_locked"=>"was not locked", 
      "not_saved"=>{"other"=>"other error"}
    }
  }, 
  "devise"=>{
    "failure"=>{"already_authenticated"=>"You are already signed in."}, 
    "sessions"=>{"signed_in"=>"Signed in successfully."}}
  }
}
````
Now! If we use flattener:
````
flat_hash = YamlConvertor.flattener(yml_hash)
````
flat_hash will look like this:
````
{
  "en.errors.messages.not_locked"=>"was not locked", 
  "en.errors.messages.not_saved.other"=>"other error", 
  "en.devise.failure.already_authenticated"=>"You are already signed in.", 
  "en.devise.sessions.signed_in"=>"Signed in successfully."
}
````

## Example 2

Now let's assume we have a flat hash and we want to rebuild it to a YAML file.
Here's our flat_hash from our example above:
````ruby
flat_hash = {"en.errors.messages.not_locked"=>"was not locked", "en.errors.messages.not_saved.other"=>"other error", "en.devise.failure.already_authenticated"=>"You are already signed in.", "en.devise.sessions.signed_in"=>"Signed in successfully."}
nested_hash = YamlConvertor.builder(flat_hash)
````
nested_hash is now:
````
{"en"=>{
  "errors"=>{
    "messages"=>{
      "not_locked"=>"was not locked", 
      "not_saved"=>{"other"=>"other error"}
    }
  }, 
  "devise"=>{
    "failure"=>{"already_authenticated"=>"You are already signed in."}, 
    "sessions"=>{"signed_in"=>"Signed in successfully."}}
  }
}
````
Dump it with Pysch..
````ruby
Psych.dump(nested_hash)
````
The output will be:
````
---
en:
  errors:
    messages:
      not_locked: was not locked
      not_saved:
        other: other error
  devise:
    failure:
      already_authenticated: You are already signed in.
    sessions:
      signed_in: Signed in successfully.
````

## Note

These methods only work properly if you have valid YAML structure. I didn't test that yet but I assume so!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
