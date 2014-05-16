request = require 'request'
zappajs = require 'zappajs'

client = require './client'

zappajs ->
  
  @enable 'zappa'

  @use 'static'
  @use 'partials'

  @enable 'zappa'

  @get '/docker/images': ->
    request 'http://docker1.rni.org:4243/images/json', (err, response, body) =>
      @send body

  @get '/docker/containers': ->
    request 'http://docker1.rni.org:4243/containers/json', (err, response, body) =>
      @send body
  
  @get '/docker/containers/:id/stop': ->
    #request.post "http://docker1.rni.org:4243/containers/#{@params.id}/stop", (err, response, body) =>
    #  console.log 'blabliebloe'
    console.log @emit.toString()
    @emit 'containers': "container stopped"
    @send 200

  @coffee '/view.js': client.view
  @client '/msgbus.js': ->
    @connect()
    @emit some: 'message'
    @on 'containers': ->
      console.log 'aaaaa'
      console.log @data

  @on connection: ->
    console.log "wieeee connection!"
    @emit 'containers': 'yes2'

  @on some: ->
    console.log "some data #{@data}"

  @get '/': ->
    @render index:
      foo: 'bar'
      title: 'Dock0rz'
      layout: 'layout'

  @view index: ->
    h1 -> 'Images'
    ul 'data-bind':'foreach: images', ->
      li 'data-bind':'foreach: RepoTags', ->
        span class:'tag', 'data-bind':'text: $data'

    h1 -> 'Containers'
    ul 'data-bind':'foreach: containers', ->
      li class:'container', ->
        span 'data-bind':'text: Image'
        div 'data-bind':'foreach: Names', ->
          span 'data-bind':'text: $data'
        input 'data-bind':'click: $root.stopContainer', type:'button', 'value':'stop'

  @view layout: ->
    doctype 5
    html ->
      head -> 
        title @title
        script src:'//code.jquery.com/jquery-2.1.1.min.js'
        script src:'//cdnjs.cloudflare.com/ajax/libs/knockout/3.1.0/knockout-min.js'
        script src:'/zappa/Zappa.js'
        script src:'view.js'
        script src:'msgbus.js'
        link rel:'stylesheet', href:'style.css'
      body @body

