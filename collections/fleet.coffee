@Machines = new Meteor.Collection 'machines'
@Units = new Meteor.Collection 'units'
@UnitTemplates = new Meteor.Collection 'unitTemplates'

UnitTemplates.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

UnitTemplates.before.update (userId, doc, fieldNames, modifier, options) ->
  modifier.$set = modifier.$set || {};
  modifier.$set.modifiedAt = Date.now();
