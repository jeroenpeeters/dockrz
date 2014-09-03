@CollectionUtils =
  setModifiedAtBeforeUpdate : (collection) ->
    if Meteor.isServer
      collection.before.update (userId, doc, fieldNames, modifier, options) ->
        modifier.$set = modifier.$set || {};
        modifier.$set.modifiedAt = Date.now();
