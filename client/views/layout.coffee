Template.layout.events =
  'change #dockerEndpoint': (event) -> Session.set 'dockerEndpoint', $(event.target).val()
  'click #menu-toggle': -> 
    $('#wrapper').toggleClass 'active'
    $('#menu-toggle').removeClass('glow')

Template.layout.helpers
  formatTime: -> moment(@time).fromNow()
  
Template.layout.rendered = ->
  Activity.find().observeChanges
    added: -> unless $('#wrapper').hasClass('active') then $('#menu-toggle').addClass('glow')