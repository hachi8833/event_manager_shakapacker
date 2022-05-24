# README

This Docker setup would help you when you learn the following Rails+React tutorial:

* [How to Create a CRUD App with Rails and React · James Hibbard](https://hibbard.eu/rails-react-crud-app/)


The setup assumes you use **Shakapacker** for bundling React.

## Requirement

The followings are required on your local environment.

* Docker and Docker Compose
* dip

[![bibendi/dip - GitHub](https://gh-card.dev/repos/bibendi/dip.svg)](https://github.com/bibendi/dip)


```sh
# to install dip in your environment
gem install dip
```

Ref: [Ruby on Whales: Dockerizing Ruby and Rails development — Martian Chronicles, Evil Martians’ team blog](https://evilmartians.com/chronicles/ruby-on-whales-docker-for-ruby-rails-development)

## Setup

Just perform the following on the root of the project. Answer 'y' when you see the prompt if Gemfile is overridden.

```sh
dip provision
```

Then you can start the tutorial from the part of updating package.json in "Creating a New Rails App"/"Shakapacker",


## FYI

You can start Rails server by:

```sh
dip dev
```

You can stop the Rails server with Ctrl-C.

You can see the list of all available dip commands by:

```sh
dip ls
```

You can prefix `dip` to the `rails` or `npm` commands for shorthands, like:

```sh
# 例
dip npm i prop-types
```

(You don't need to prefix `dip` to shell commands such as `touch` or `mkdir`)
