@Projects = new Meteor.Collection 'projects'

Projects.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

Activity.streamHook Projects

if Meteor.isServer
  Projects.before.update (userId, doc, fieldNames, modifier, options) ->
    modifier.$set = modifier.$set || {};
    modifier.$set.modifiedAt = Date.now();
