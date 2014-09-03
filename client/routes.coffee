extend = (src, dest) -> _.extend dest, src

Meteor.startup ->

  BaseController = RouteController.extend
    layoutTemplate: 'layout'
    data:
      activities: -> Activity.find {}, {sort: {time: -1}}

  DockerController = BaseController.extend
    data: extend BaseController.prototype.data,
      subMenu: Template.dockerMenu
      activeDocker: class:"active"
      numContainers: -> Containers.find().count()
      numImages: -> Images.find().count()
      docker:
        endpoints: settings.docker.endpoints


  FleetController = BaseController.extend
    data: extend BaseController.prototype.data,
      subMenu: Template.fleetMenu
      activeFleet: class:"active"

  ProjectsController = BaseController.extend
    data: extend BaseController.prototype.data,
      subMenu: Template.projectsMenu
      activeProjects: class:"active"

  ApplicationsController = BaseController.extend
    data: extend BaseController.prototype.data,
      subMenu: Template.applicationsMenu
      activeApplications: class:"active"

  Router.map ->
    @route 'home',
      path: '/'
      controller: BaseController

    @route 'registry',
      path: '/docker/registry'
      controller: DockerController.extend
        data: extend DockerController.prototype.data,
          registry: -> Registry.find {name: {$regex: "#{Session.get('registryFilter')}"}}
          activeRegistry: 'active'

    @route 'images',
      path: '/docker/images'
      controller: DockerController.extend
        data: extend DockerController.prototype.data,
          imageFilter: -> Session.get 'imageFilter'
          images: -> Images.find $or: [{RepoTags: {$regex: "#{Session.get('imageFilter')}"}}, {Id: {$regex: "#{Session.get('imageFilter')}"}}]
          activeImages: 'active'

    @route 'containers',
      path: '/docker/containers'
      controller: DockerController.extend
        data: extend DockerController.prototype.data,
          containerFilter: -> Session.get 'containerFilter'
          containers: -> Containers.find $or: [{Names: {$regex: "#{Session.get('containerFilter')}"}}, {Image: {$regex: "#{Session.get('containerFilter')}"}}]
          activeContainers: 'active'

    @route 'fleet',
      path: '/fleet/units'
      controller: FleetController.extend
        data: extend FleetController.prototype.data,
          units: -> Units.find {unit: {$regex: "#{Session.get('unitFilter')}"}}
          unitTemplates: -> UnitTemplates.find {}, {sort: {name:1}}
          activeUnits: 'active'

    @route 'unitTemplates',
      path: '/fleet/unit-templates'
      controller:  FleetController.extend
        data: extend FleetController.prototype.data,
          templates: -> UnitTemplates.find {}, {sort: {name:1}}
          selectedTemplate: ->
            Meteor.subscribe 'template', Session.get('selectedUnitTemplateId')
            UnitTemplates.findOne _id: Session.get('selectedUnitTemplateId')
          activeUnitTemplates: 'active'

    @route 'machines',
      path: '/fleet/machines'
      controller:  FleetController.extend
        data: extend FleetController.prototype.data,
          machines: -> Machines.find()
          activeMachines: 'active'

    @route 'projects',
      path: '/projects/overview'
      controller:  ProjectsController.extend
        data: extend ProjectsController.prototype.data,
          activeProjects: class:"active"
          projects: -> Projects.find()
          selectedProject: ->
            Meteor.subscribe 'project', Session.get('selectedProjectId')
            Projects.findOne _id: Session.get('selectedProjectId')

    @route 'applications',
      path: '/applications/overview'
      controller:  ApplicationsController.extend
        data: extend ApplicationsController.prototype.data,
          applications: -> Applications.find()
          selectedApplication: ->
            Meteor.subscribe 'application', Session.get('selectedApplicationId')
            Applications.findOne _id: Session.get('selectedApplicationId')
