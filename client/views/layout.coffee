Template.layout.events =
  'change #dockerEndpoint': (event) -> Session.set 'dockerEndpoint', $(event.target).val()
