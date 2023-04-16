package main

import (
	"net/http"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()
	r.LoadHTMLGlob("templates/*.tmpl")

	r.GET("/", func(c *gin.Context) {
		c.Redirect(http.StatusMovedPermanently, "/hello")
	})

	r.GET("/hello", func(c *gin.Context) {
		scheme := "http"
		if c.Request.TLS != nil {
			scheme = "https"
		}

		host_in_bytes := c.Request.Host
		host_with_port := strings.Split(host_in_bytes, ":")
		host := host_with_port[0]

		var port int

		if len(host_with_port) < 2 {
			port = 80
		} else {
			port, _ = strconv.Atoi(host_with_port[1])
		}

		c.HTML(http.StatusOK, "main.tmpl", gin.H{"scheme": scheme, "host": host, "port": port})
	})

	r.POST("/fibonacci", func(c *gin.Context) {
		number, err := strconv.Atoi(c.PostForm("number"))
		if err != nil {
			c.JSON(http.StatusBadRequest, "C'mon dude, take it easy.")
			panic(err)
		}

		result := FibonacciGenerator(number)

		c.JSON(http.StatusOK, gin.H{"number": number, "result": result})
	})

	r.Run(":8000")
}
