Meteor.startup ->

  Containers.remove {}
  Images.remove {}
  Machines.remove {}
  Units.remove {}
  
  _refresh()
  Meteor.setInterval _refresh, 10000

Meteor.publish 'containers', (endpoint) -> Containers.find {Endpoint: endpoint}
Meteor.publish 'images', (endpoint) -> Images.find {Endpoint: endpoint}
Meteor.publish 'machines', () -> Machines.find {}
Meteor.publish 'units', () -> Units.find {}

Meteor.methods
  startContainer: Docker.startContainer
  stopContainer: Docker.stopContainer
  removeContainer: Docker.removeContainer
  createContainer: Docker.createContainer
  
_refresh = ->
  Docker.refreshContainers()
  Docker.refreshImages()
  Fleet.listMachines()
  Fleet.listUnits()
