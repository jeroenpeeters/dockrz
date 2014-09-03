@Projects  = new Meteor.Collection 'projects'

Projects.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

Activity.streamHook Projects
CollectionUtils.setModifiedAtBeforeUpdate Projects

