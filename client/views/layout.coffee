Template.layout.events =
  'change #dockerEndpoint': (event) -> Session.set 'dockerEndpoint', $(event.target).val()
  'click #menu-toggle': -> $('#wrapper').toggleClass 'active'

Template.layout.helpers
  formatTime: -> moment(@time).fromNow()
