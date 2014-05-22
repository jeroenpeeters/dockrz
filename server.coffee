request = require 'request'
zappajs = require 'zappajs'

views = require './views'
client = require './client'
docker = require './docker'
fleet = require './fleet'

zappajs ->

  @use 'static'
  @use 'partials'

  @enable 'zappa'

  @get '/': ->
    @render index:
      foo: 'bar'
      title: 'Dockrz'
      layout: 'layout'
  @get '/fleet/machines': ->
    fleet.machines (data) =>
      @json data

  @client '/view.js': client.view

  @on 'containers/stop': ->
    docker.container.stop @data, => docker.containers (data) => @emit containers: data
  @on 'containers/start': ->
    docker.container.start @data, => docker.containers (data) => @emit containers: data
  @on 'containers/remove': ->
    docker.container.remove @data, => docker.containers (data) => @emit containers: data
  @on 'containers/create': ->
    docker.container.create @data, (data) => console.log data
    
  @on connection: ->
    docker.containers (data) => @emit containers: data
    docker.images (data) => @emit images: data

  @on some: ->
    console.log "some data #{@data}"

  @view index: views.index
                
  @view layout: views.layout
