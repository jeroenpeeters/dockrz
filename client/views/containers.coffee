Template.containers.events =
  'click .startContainer': -> Meteor.call 'startContainer', @Id, Session.get('dockerEndpoint')
  'click .stopContainer': -> Meteor.call 'stopContainer', @Id, Session.get('dockerEndpoint')
  'click .removeContainer': -> Meteor.call 'removeContainer', @Id, Session.get('dockerEndpoint')

Template.layout.events =
  'change #dockerEndpoint': (event) -> Session.set 'dockerEndpoint', $(event.target).val()

Template.containers.isUp = -> ~@Status.indexOf('Up')
