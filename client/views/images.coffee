Template.images.events =
  'click .createContainer': -> Meteor.call 'createContainer', @Id, Session.get('dockerEndpoint')
