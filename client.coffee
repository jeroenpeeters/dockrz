exports.view = ->
  ImagesViewModel = ->
    @images = ko.observableArray()
    @containers = ko.observableArray()

    $.getJSON '/docker/images', @images
    $.getJSON '/docker/containers', @containers

    @stopContainer = (container) =>  
      console.log container
      $.ajax
        url: "/docker/containers/#{container.Id}/stop",
        type: 'PUT',
        success: (result) ->
          console.log result
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
      
