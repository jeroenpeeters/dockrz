mdl = null

exports.view = ->
  zppa = @     # create zappa alias
  @connect()   # socket.io connect

  # Knockout view model
  ViewModel = ->
    @page = ko.observable 'home'

    @images = ko.observableArray()
    @containers = ko.observableArray()

    @stopContainer = (container) ->
      zppa.emit 'containers/stop': container

    @startContainer = (container) ->
      zppa.emit 'containers/start': container

    @toHomePage = ->
      @page('home')
    @toImagesPage = ->
      @page('images')
    @toContainersPage = ->
      @page('containers')
    @

  # Setup view model and connect to socket.io streams
  $ =>
    mdl = new ViewModel()

    @on containers: ->
      mdl.containers @data
    @on images: ->
      mdl.images @data

    ko.applyBindings mdl

  # Configure Sammy routes
  @get '#/home': ->
    mdl.toHomePage()
  @get '#/images': ->
    mdl.toImagesPage()
  @get '#/containers': ->
    mdl.toContainersPage()



