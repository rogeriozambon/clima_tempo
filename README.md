# ClimaTempo

Get brazilian weather values of the ClimaTempo.

## Installation

~~~.ruby
gem install clima_tempo
~~~

## Usage

~~~.ruby
require "rubygems"
require "clima_tempo"

climatempo = ClimaTempo.new(:code => 558)

now = climatempo.now

now[:temperature]
#=> 25ºC

now[:pressure]
#=> 1010 hPa

now[:moisture]
#=> 50%

today_forecast = climatempo.today_forecast

today_forecast[:condition]
#=> "Sol com algumas nuvens. Não chove."

today_forecast[:min]
#=> "12º"

today_forecast[:max]
#=> "26º"

today_forecast[:probability_of_precipitation]
#=> "0%"
~~~

## Maintainer

* Rogério Zambon (http://rogerio.me)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
