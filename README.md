# ruby_2_brain_fuck
This is a simple compiler to convert a Ruby code into Brain Fuck code written by Chat-GPT upon
my command.

```Usage```

```ruby
require 'ruby_2_brain_fuck.rb'

ruby_code = <<~RUBY
  my_var = "Hello, world!"
  puts my_var
  x = 42
  puts "The answer is " + x.to_s
RUBY

brainfuck_code = Ruby2BrainFuck.new(ruby_code).compile
puts brainfuck_code
```

This outputs:
```brain_fuck
  ++++++++[>++++[>++>+++>+++>+<<<<-]>+>+>->>+[<]<-]>>.>---.+++++++..+++.>>.<-.<.+++.------.--------.>>+.>++.\n[-]>+72.<>+101.<>+108.<>+108.<>+111.<>+44.<>+32.<>+119.<>+111.<>+114.<>+108.<>+100.<>+33.<[-]>+[-]<[-]>+.<[-]>+42.<[-]>+[<]<[-]>+.<
```
