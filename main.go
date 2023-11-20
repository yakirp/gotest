package main

import (
	"fmt"
	"net/http"
)

func main() {
    http.HandleFunc("/", handler) // each request calls handler
    fmt.Println("Starting server at :8080")
    http.ListenAndServe(":8080", nil) // setting listening port
}

func handler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, this is a simple Go server!") // send data to client side
}
