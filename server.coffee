request = require 'request'
zappajs = require 'zappajs'

client = require './client'
docker = require './docker'

zappajs ->

  @use 'static'
  @use 'partials'

  @enable 'zappa'

  @get '/': ->
    @render index:
      foo: 'bar'
      title: 'Dockrz'
      layout: 'layout'

  @client '/view.js': client.view

  @on 'containers/stop': ->
    docker.stop @data, => docker.containers (data) => @emit containers: data

  @on 'containers/start': ->
    docker.start @data, => docker.containers (data) => @emit containers: data

  @on connection: ->
    docker.containers (data) => @emit containers: data
    docker.images (data) => @emit images: data

  @on some: ->
    console.log "some data #{@data}"

  @view index: ->
    div class:'page', 'data-bind':"visible: page() === 'home'", -> 'Welcome to the amazing Dockerz.... Gantcho-style'

    div class:'page', 'data-bind':"visible: page() === 'images'", ->
      h1 -> 'Images'
      ul 'data-bind':'foreach: images', ->
        li 'data-bind':'foreach: RepoTags', ->
          span class:'tag', 'data-bind':'text: $data'

    div class:'page', 'data-bind':"visible: page() === 'containers'", ->
      div class:'panel panel-default', ->
        div class:'panel-heading', -> strong -> 'Containers'
        table class:'table table-striped', ->
          thead ->
            tr ->
              th ->
              th -> 'Status'
              th -> 'Image'
              th -> 'Names'
              th ->
          tbody 'data-bind':'foreach: containers', ->
            tr ->
              td 'data-bind':'css:{success:~$data.Status.indexOf(\'Up\'), danger:$data.Status.indexOf(\'Up\')}', -> '&nbsp'
              td 'data-bind':'text:Status'
              td 'data-bind':'text:Image'
              td 'data-bind':'foreach: Names', ->
                div 'data-bind':'text: $data'
              td ->
                input 'data-bind':'click: $root.startContainer, visible: $data.Status.indexOf(\'Up\')', type:'button', 'value':'start'
                input 'data-bind':'click: $root.stopContainer, visible: ~$data.Status.indexOf(\'Up\')', type:'button', 'value':'stop'

  @view layout: ->
    doctype 5
    html ->
      head ->
        title @title
        link rel:'stylesheet', href:'//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css'
        link rel:'stylesheet', href:'//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css'
        link rel:'stylesheet', href:'style.css'
        script src:'//code.jquery.com/jquery-2.1.1.min.js'
        script src:'//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js'
        script src:'//cdnjs.cloudflare.com/ajax/libs/knockout/3.1.0/knockout-min.js'
        script src:'/zappa/Zappa.js'
        script src:'view.js'

      body ->
        nav class:'navbar navbar-default navbar-fixed-top', role:'navigation', ->
          div class:'navbar-header', ->
            a class:'navbar-brand', href:'#/home', -> 'Dockerz'
          ul class:'nav navbar-nav', ->
            li 'data-bind':'css:{active: page() === \'images\'}', -> a href:'#/images', -> 'Images'
            li 'data-bind':'css:{active: page() === \'containers\'}', -> a href:'#/containers', -> 'Containers'
        @body

