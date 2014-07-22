@Activity = new Meteor.Collection 'activity'

Activity.streamHook = (collection) ->
  if Meteor.isServer
    collection.after.insert Activity.objectCreated collection
    collection.after.remove Activity.objectRemoved collection

Activity.objectCreated = (collection) -> (userId, doc) ->
  Activity.insert
    type: 'insert'
    collection: collection._name
    userId: userId
    doc: doc

Activity.objectRemoved = (collection) -> (userId, doc) ->
  Activity.insert
    type: 'remove'
    collection: collection._name
    userId: userId
    doc: doc

if Meteor.isServer
  Activity.before.insert (userId, doc) ->
    doc.time = Date.now()
