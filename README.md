# Hangman Game
### From Dave Thomas' "Elixir for Programmers"


## Overview
Project structure is one of the main focuses of this project. This project consists of three Elixir applications, which work together as a hangman game.

- dictionary ........ Basically just a word bank
- hangman    ........ The core logic/API for the game
- console_client .... Text-based user interface

State management is another focus of this project. *How can state be cleanly shared across Elixir applciations?* Modules in Elixir do not keep state. State can be shared by passing immutable copies through the API.

This is a work in progress, so there's more to come.
