This is a simple a customizable concern you can include in a controller to create CRUD actions and serialize object by using [ActiveModelSerializer](https://github.com/rails-api/active_model_serializers).

## Installation

Add this line to your application's Gemfile:

    gem 'crud_concern'

And then execute:

    $ bundle
Or install it yourself as:

    $ gem install crud_concern

## Usage
  
Simply include the concern in your controller like:

    class ContactsController < ApplicationController
      include CrudConcern
    end

You can now use normal crud actions !

If you are lazy, you can simply include it in `ApplicationController` to have it everywhere.

## Override it

The code is simple enough to understand it easily. Each methods are explict and designed to be understood by reading it. You can override each actions.
