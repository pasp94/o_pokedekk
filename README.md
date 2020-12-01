<img src="./resources/O_Pokedek_logo.png"/>


[![Swift 5.3](https://img.shields.io/badge/Swift-5.3-orange.svg?style=flat)](https://swift.org)


# O' Pokedekk

A Napoletan version of a famous tool used for getting information about Pokemons!! 😜

The goal of this project is resolve the given track using a simple and, as much as possible, decopulated architecture, core frameworks and without using any [external libraries.](#External libreries)

# Architecture

Thi Architecture used for this project is `MVVM` with the help of `Coordinator` pattetern (in project is used [`Router`](#Router) and `AppRouter` to specifithe Coordinator implementation), inorder to navigate the App Screen and [`Provider`](#Provider) to fetch the informations and models.

### Folders structure
* [Models](#Models)
    * ApiResponse - The models here defined map the api responces
* [Views](#Views)
    * ViewControllers
    * Cells
    * Protocols - Intefaces for any Views implementations
* [ViewModel](#ViewModel)
    * Cells
    * Protocols - Intefaces for View Models implementations
* Navigation

* Network
    * Protocols - Intefaces for [`Provider`](#Provider) implementation

## Models
The models won't store business logic. They will only act as data stores. It's implemented a Cache mechanism to store temporarily the fetched information 
in order to not create an overhead of HTTP requests and make the UX more fluid.

## Views
The `Views` (or `ViewControllers` in this case) only responsability will be displaying the data provided by its `ViewModel`, and forwarding all events to their respective `ViewModel`.

## ViewModel
The `ViewModel` is the component in charge of managing the state of each view, managing the `Models`, and any processing necesary of the data to be displayed.

Moreover, the VM communicates with `Provider` to fetch the data necessary for its view. And with its `Router` to forward navigation events.

## Provider
The `Provider` is in charge of End Point building, API call execution, network error handling and decoding of the recieving data.

(The concrete imlementation is the class `PokemonAPIManager` that is conform to the `APIProvider` and `PokemonProvider` protocols.

## Router
The router is the component in charge of handling the navigation stack of your entire application. For this matter, the router keeps track of the `UINavigationController`  that manage the stack of `ViewControllers` and makes free from any responsabiliry of that the rispective ViewModels.

The router is the only one that knows how to instantiate the screens to presente presents. Each VM needs to specify only the `AppContext` that want to reach. In this way the navigation is decolulated from VMs and the only one that are in charge of it is the concreate implementation of the `Router` protocol.

For the sake of simplicity the only navigatio transition implemented is push and pop from stack. In the future implementation, this protocol could be improvede with `TransitionType` in order to tells the navigator how the screen should be presenter (modally, pushed, resetting the stack, etc.)

## External libreries

No external libraries were used for this project. This choice arises from the evaluation of no need to depend on libraries that contain modules not used in this app, thus introducing only performances overead.