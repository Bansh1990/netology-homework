package main

import "fmt"

    func main() {
        fmt.Print("Enter a number: ")
        var meters float64
        fmt.Scanf("%f", &meters)

        fut := meters / 0.3048

        fmt.Println(meters, "м. это ", fut, "ф.")
    }