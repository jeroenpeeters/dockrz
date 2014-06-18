document.title = 'Dockrz'

Session.set 'dockerEndpoint', settings.docker.endpoints[0]
Session.set 'imageFilter', ''
Session.set 'containerFilter', ''

Meteor.subscribe 'registry'
Meteor.subscribe 'machines'
Meteor.subscribe 'units'
Meteor.subscribe 'templates'

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

  @route 'registry',
    path: '/registry'
    data:
      registry: -> Registry.find $or: [{name: {$regex: "#{Session.get('registryFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeRegistry: class:"active"
      docker:
        endpoints: settings.docker.endpoints

  @route 'images',
    path: '/images'
    data:
      imageFilter: -> Session.get 'imageFilter'
      images: -> Images.find $or: [{RepoTags: {$regex: "#{Session.get('imageFilter')}"}}, {Id: {$regex: "#{Session.get('imageFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeImages: class:"active"
      docker:
        endpoints: settings.docker.endpoints

  @route 'containers',
    path: '/containers'
    data:
      containerFilter: -> Session.get 'containerFilter'
      containers: -> Containers.find $or: [{Names: {$regex: "#{Session.get('containerFilter')}"}}, {Image: {$regex: "#{Session.get('containerFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeContainers: class:"active"
      docker:
        endpoints: settings.docker.endpoints

  @route 'fleet',
    path: '/fleet'
    data:
      machines: -> Machines.find()
      units: -> Units.find()
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeFleet: class:"active"
      docker:
        endpoints: settings.docker.endpoints

  @route 'unitTemplates',
    path: '/unit-templates'
    data:
      templates: -> UnitTemplates.find {}, {sort: {name:1}}
      selectedTemplate: ->
        Meteor.subscribe 'template', Session.get('selectedUnitTemplateId')
        UnitTemplates.findOne _id: Session.get('selectedUnitTemplateId')
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeUnitTemplates: class:"active"
      docker:
        endpoints: settings.docker.endpoints
