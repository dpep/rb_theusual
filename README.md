TheUsual
======
![Gem](https://img.shields.io/gem/dt/theusual?style=plastic)
[![codecov](https://codecov.io/gh/dpep/rb_theusual/branch/main/graph/badge.svg)](https://codecov.io/gh/dpep/rb_theusual)

A handful of useful hacks...good for any project


#### Install
```gem install theusual```


#### Usage
```ruby
require 'theusual'
TheUsual::load :all

Hash.hmap [:a, :b, :c] do |v|
  [ v, v ]
end
# => { a: :a, b: :b, c: :c }


[:a, nil, '', :b].compact :blanks
# => [ :a, :b ]
```
