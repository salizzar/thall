const express = require('express')
const bodyParser = require('body-parser')
const app = express()

const fibonacciGenerator = (index) =>
  Array.from({ length: index }).reduce(
    (acc, val, i) => acc.concat(i > 1 ? acc[i - 1] + acc[i - 2] : i),
    []
  )[index-1]


app.use(bodyParser.urlencoded({ extended: true }))


app.get('/', (req, res) => {
  res.redirect(302, '/hello')
})


app.get('/hello', (req, res) => {
  const scheme = req.protocol

  const fullHost = req.headers.host.split(':')
  const host = fullHost[0]
  const port = fullHost[1]

  res.send(`
Hey dude, do you want to know some Fibonacci numbers? Send a post to /fibonacci here with the following payload:

curl -XPOST -d 'number=<<some number you want to know in the Fibonacci algorithm>>' ${scheme}://${host}:${port}/fibonacci

`
  )
})


app.post('/fibonacci', (req, res) => {
  const number = req.body.number

  if (number == undefined) {
    res.send("C'mon dude, take it easy.\n")
    return
  }

  const result = fibonacciGenerator(number)

  res.send(`${JSON.stringify({
    number: number,
    result: result
  })}\n`)
})


app.listen(8000, '0.0.0.0')
