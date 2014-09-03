@Applications = new Meteor.Collection 'applications'

Applications.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

Activity.streamHook Applications
CollectionUtils.setModifiedAtBeforeUpdate Applications
