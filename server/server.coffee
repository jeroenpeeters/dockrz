Meteor.startup ->

  Containers.remove {}
  Images.remove {}
  Machines.remove {}
  Units.remove {}
  Registry.remove {}

  _refresh()
  Meteor.setInterval _refresh, 10000

Meteor.publish 'registry', () -> Registry.find {}
Meteor.publish 'containers', (endpoint) -> Containers.find {Endpoint: endpoint}
Meteor.publish 'images', (endpoint) -> Images.find {Endpoint: endpoint}
Meteor.publish 'machines', () -> Machines.find {}
Meteor.publish 'units', () -> Units.find {}

Meteor.methods
  startContainer: Docker.startContainer
  stopContainer: Docker.stopContainer
  removeContainer: Docker.removeContainer
  createContainer: Docker.createContainer
  createImage: Docker.createImage
  startUnit: Fleet.startUnit
  stopUnit: Fleet.stopUnit
  destroyUnit: Fleet.destroyUnit
  submitUnit: Fleet.submitUnit
  getUnitSource: Fleet.getUnitSource

_refresh = ->
  Docker.loadRegistry()
  Docker.refreshContainers()
  Docker.refreshImages()
  Fleet.listMachines()
  Fleet.listUnits()
