# getto-initialize_with

[rubygems: getto-initialize_with](https://rubygems.org/gems/getto-initialize_with)

Define initialize method that require specific parameters

- purpose : for type annotation

```ruby
require "getto/initialize_with"

class MyClass
  include Getto::InitializeWith

  initialize_with(
    :time,

    # assert expire is a Integer
    expire: Integer,

    # assert repository respond to methods
    repository: [
      :account_exists?,
    ],
  )
end

class Repository
  def account_exists?
    true
  end
end


my_class = MyClass.new(
  time: :now,
  expire: 10,
  repository: Repository.new,
)
my_class.time       # => :now
my_class.expire     # => 10
my_class.repository # => Repository instance
```


###### Table of Contents

- [Requirements](#Requirements)
- [Usage](#Usage)
- [License](#License)

<a id="Requirements"></a>
## Requirements

- developed on ruby: 2.5.1


<a id="Usage"></a>
## Usage

```ruby
require "getto/initialize_with"

class MyClass
  include Getto::InitializeWith

  initialize_with(
    :time,

    expire: Integer,

    repository: [
      :account_exists?,
    ],
  )
end
```

### Errors

raise error when missing argument, or unknown argument, object not satisfied signature or type check failed

```ruby
# raise "argument missing" becouse missing `repository`
my_class = MyClass.new(time: :now, expire: 10)

# raise "unknown argument" because including `unknown`
my_class = MyClass.new(time: :now, expire: 10, repository: Repository.new, unknown: :argument)

# raise "argument type error" because `repository` is not respond to [:account_exists?]
my_class = MyClass.new(time: :now, expire: 10, repository: Object.new)

# raise "argument type error" because `expire` is not a Integer
my_class = MyClass.new(time: :now, expire: "10", repository: Repository.new)
```


## Install

Add this line to your application's Gemfile:

```ruby
gem 'getto-initialize_with'
```

And then execute:

```
$ bundle
```

Or install it yourself as:

```
$ gem install getto-initialize_with
```


<a id="License"></a>
## License

getto/initialize_with is licensed under the [MIT](LICENSE) license.

Copyright &copy; since 2018 shun@getto.systems
