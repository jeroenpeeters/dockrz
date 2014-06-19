Meteor.startup ->
  messages.on 'error', (msg) -> FlashMessages.sendError msg
  messages.on 'warning', (msg) -> FlashMessages.sendWarning msg
  messages.on 'success', (msg) -> FlashMessages.sendSuccess msg
  messages.on 'info', (msg) -> FlashMessages.sendInfo msg
