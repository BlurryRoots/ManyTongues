# Usage

###General:

```ruby main.rb [options] [names]```

###Examples:

```ruby main.rb lovecraft``` => ```L126```

You can also provide any number of names, which will print their respective code in the same order passed.

```ruby main.rb lovecraft loafkraft``` => ```L126 L126```

It's possible to get the full code, instead of the shortened version, by passing the ```-F``` option.

```ruby main.rb -F loafkraft``` => ```L12613```

You can check names for equal code if you pass the ```-eq``` option.

```ruby main.rb -eq loafkraft lovecraft``` => ```eq:true L126```
