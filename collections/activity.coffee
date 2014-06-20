@Activity = new Meteor.Collection 'activity'

if Meteor.isServer
  Activity.before.insert (userId, doc) ->
    doc.time = Date.now()
