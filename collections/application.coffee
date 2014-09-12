@ApplicationTemplates = new Meteor.Collection 'applicationTemplates'
@Applications = new Meteor.Collection 'applications'

ApplicationTemplates.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

Applications.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

Activity.streamHook ApplicationTemplates
CollectionUtils.setModifiedAtBeforeUpdate ApplicationTemplates

Activity.streamHook Applications
CollectionUtils.setModifiedAtBeforeUpdate Applications

