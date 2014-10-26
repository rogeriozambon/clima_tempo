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

clima_tempo = ClimaTempo.new(558)

clima_tempo.now
#=> { :temperature => "22ºC", :wind => "Su-sudeste", :condition => "Muitas nuvens", :pressure => "1015 hPa", :intensity => "11 km/h", :moisture => "73%" }

clima_tempo.today_forecast
#=> { :condition => "Sol com muitas nuvens. Pancadas de chuva à tarde e à noite.", :min => "17º", :max => "27º", :probability_of_precipitation => "64%" }
~~~

## Maintainer

* Rogério Zambon (http://rogerio.me)

## License

(The MIT License)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the 'Software'), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
