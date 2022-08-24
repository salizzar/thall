package main

import (
	"net/http"

	"fmt"
	"strconv"
	"strings"

	"github.com/gin-gonic/gin"
)

func main() {
	r := gin.Default()

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
		port := host_with_port[1]

		c.HTML(http.StatusOK, "raw.tmpl", gin.H{
			"scheme": scheme,
			"host":   host,
			"port":   port,
		})

		c.HTML(http.StatusOK, "hehe", gin.H{})
	})

	r.POST("/fibonacci", func(c *gin.Context) {
		number, err := strconv.Atoi([]string(c.Request.PostForm["number"])[0])
		if err != nil {
			c.HTML(http.StatusBadRequest, "C'mon dude, take it easy.", gin.H{})
		}

		fmt.Printf("aqui: %s", number)

		result := FibonacciGenerator(number)

		c.JSON(http.StatusOK, gin.H{"number": number, "result": result})
	})

	r.Run(":8000")
}
