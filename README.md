<img src="./resources/O_Pokedek_logo.png"/>


[![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat)](https://swift.org)


# O' Pokedekk

A Napoletan version of a famous tool used for getting information about Pokemons!! 😜

The goal of this project is resolve the given track using a simple and, as much as possible, decopulated architecture, core frameworks and without using any external libraries.

# Architecture

Thi Architecture used for this project is `MVVM` with the help of `Coordinator` pattetern, inorder to navigate the App Screen and `APIProvider` to fetch the informations and models.

## Models
The models won't store business logic. They will only act as data stores. It's implemented a Cache mechanism to store temporarily the fetched information 
in order to not create an overhead of HTTP requests and make the UX more fluid.
