document.title = 'Dockrz'

Session.set 'dockerEndpoint', settings.docker.endpoints[0]
Session.set 'imageFilter', ''
Session.set 'containerFilter', ''
Session.set 'registryFilter', ''
Session.set 'unitFilter', ''

Meteor.subscribe 'registry'
Meteor.subscribe 'machines'
Meteor.subscribe 'units'
Meteor.subscribe 'templates'
Meteor.subscribe 'activities'
Meteor.subscribe 'projects'

Deps.autorun ->
  Meteor.subscribe 'containers', Session.get('dockerEndpoint')
  Meteor.subscribe 'images', Session.get('dockerEndpoint')
