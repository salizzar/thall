require FibonacciGenerator

defmodule App.Router do
  use Trot.Router

  get "/" do
    {:redirect, "/hello"}
  end

  get "/hello" do
    scheme = "http"
    host = "localhost"
    port = 8000

    body = """
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d \'number=<<some number you want to know in the Fibonacci algorithm>>\' #{scheme}://#{host}:#{port}/fibonacci

"""

    {200, body}
  end

  post "/fibonacci" do
    {number, _} = Integer.parse(conn.body_params["number"])
    result = FibonacciGenerator.calculate(number)

    payload = [
      number: number,
      result: result
    ]

    {_, json} = JSON.encode(payload)

    {200, json}
  end
end
