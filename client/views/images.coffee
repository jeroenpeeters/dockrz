Template.images.events =
  'click .addContainer': -> Meteor.call 'createContainer', @Id