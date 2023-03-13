# app

require 'cuba'
require 'cuba/safe'
require 'json'

# classes
require_relative 'fibonacci_generator'


Cuba.define do
  on root do
    res.redirect '/hello'
  end

  on get do
    on 'hello' do
      protocol = env['rack.url_scheme']
      host = env['SERVER_NAME']
      port = env['SERVER_PORT']

      res.write %{
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d 'number=<<some number you want to know in the Fibonacci algorithm>>' #{protocol}://#{host}:#{port}/fibonacci

%}
    end
  end

  on post do
    on 'fibonacci' do
      on param('number') do |number|
        index = number.to_i
        fibonacci = FibonacciGenerator.new(index)

        answer = {
          number: index,
          result: fibonacci.calculate
        }

        res.write "#{JSON.dump(answer)}\n"
      end
    end

    on true do
      res.write %{
C'mon dude, take it easy.
%}
    end
  end
end

