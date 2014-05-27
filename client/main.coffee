Session.set 'dockerEndpoint', settings.docker.endpoints[0]

Deps.autorun ->
  Meteor.subscribe 'containers', Session.get('dockerEndpoint')
  Meteor.subscribe 'images', Session.get('dockerEndpoint')

Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home',
    path: '/'
    data:
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      docker:
        endpoints: settings.docker.endpoints

  @route 'images',
    path: '/images'
    data:
      images: Images.find()
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeImages: class:"active"
      docker:
        endpoints: settings.docker.endpoints

  @route 'containers',
    path: '/containers'
    data:
      containers: Containers.find()
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeContainers: class:"active"
      docker:
        endpoints: settings.docker.endpoints
