exports.view = ->
 # console.log "zappa", zappa
  @connect()
  @emit 'containers/stop': 123
  ImagesViewModel = ->
    @images = ko.observableArray()
    @containers = ko.observableArray()

    #$.getJSON '/docker/images', @images
    $.getJSON '/docker/containers', @containers

    @stopContainer = (container) ->
      zappa.emit 'containers/stop': container.Id
    @
  $ ->
    ko.applyBindings(new ImagesViewModel())

exports.msgbus = ->
  @connect()
  @emit some: 'message'
  $ =>
    @on containers: ->
      console.log 'aaaaa'
      console.log @data

