from flask import Flask, request, redirect
from urllib.parse import urlparse
import os
import json as JSON
from fibonacci_generator import FibonacciGenerator


ENABLE_DEBUG = False
DEFAULT_HOST = '0.0.0.0'
DEFAULT_PORT = 8000


app = Flask(__name__)


@app.route('/')
def root():
    return redirect('/hello', 302)


@app.route('/hello')
def hello(methods=['GET']):
    parsed = urlparse(request.base_url)

    protocol = parsed.scheme
    host = parsed.hostname
    port = parsed.port

    return """
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d \'number=<<some number you want to know in the Fibonacci algorithm>>\' %s://%s:%s/fibonacci

""" % (protocol, host, port)


@app.route('/fibonacci', methods=['POST'])
def fibonacci():
    params = list(request.form.keys())
    if 'number' in params:
        index = int(request.form['number'])
        fibonacci = FibonacciGenerator(index)

        answer = {
            'number': index,
            'result': fibonacci.calculate()
        }

        return("%s\n" % JSON.dumps(answer))
    else:
      return "what a fuck man"

    return "C'mon dude, take it easy"


if __name__ == "__main__":
    debug = bool(os.environ.get('DEBUG', ENABLE_DEBUG))
    host = str(os.environ.get('HOST', DEFAULT_HOST))
    port = int(os.environ.get('PORT', DEFAULT_PORT))

    app.run(debug=debug, host=host, port=port)

