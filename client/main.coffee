document.title = 'Dockrz'

Session.set 'dockerEndpoint', settings.docker.endpoints[0]
Session.set 'imageFilter', ''
Session.set 'containerFilter', ''
Session.set 'registryFilter', ''

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
    path: '/docker/registry'
    data:
      registry: -> Registry.find $or: [{name: {$regex: "#{Session.get('registryFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeDocker: class:"active"
      activeRegistry: 'active'
      subMenu: Template.dockerMenu
      docker:
        endpoints: settings.docker.endpoints

  @route 'images',
    path: '/docker/images'
    data:
      imageFilter: -> Session.get 'imageFilter'
      images: -> Images.find $or: [{RepoTags: {$regex: "#{Session.get('imageFilter')}"}}, {Id: {$regex: "#{Session.get('imageFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeDocker: class:"active"
      activeImages: 'active'
      subMenu: Template.dockerMenu
      docker:
        endpoints: settings.docker.endpoints

  @route 'containers',
    path: '/docker/containers'
    data:
      containerFilter: -> Session.get 'containerFilter'
      containers: -> Containers.find $or: [{Names: {$regex: "#{Session.get('containerFilter')}"}}, {Image: {$regex: "#{Session.get('containerFilter')}"}}]
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      activeDocker: class:"active"
      activeContainers: 'active'
      subMenu: Template.dockerMenu
      docker:
        endpoints: settings.docker.endpoints

  @route 'fleet',
    path: '/fleet/units'
    data:
      units: -> Units.find()
      activeFleet: class:"active"
      activeUnits: 'active'
      subMenu: Template.fleetMenu

  @route 'unitTemplates',
    path: '/fleet/unit-templates'
    data:
      templates: -> UnitTemplates.find {}, {sort: {name:1}}
      selectedTemplate: ->
        Meteor.subscribe 'template', Session.get('selectedUnitTemplateId')
        UnitTemplates.findOne _id: Session.get('selectedUnitTemplateId')
      activeFleet: class:"active"
      activeUnitTemplates: 'active'
      subMenu: Template.fleetMenu

  @route 'machines',
    path: '/fleet/machines'
    data:
      machines: -> Machines.find()
      activeFleet: class:"active"
      activeMachines: 'active'
      subMenu: Template.fleetMenu
