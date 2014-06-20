@Machines = new Meteor.Collection 'machines'
@Units = new Meteor.Collection 'units'
@UnitTemplates = new Meteor.Collection 'unitTemplates'

UnitTemplates.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}

if Meteor.isServer
  UnitTemplates.after.insert (userId, doc, fieldNames, modifier, options) ->
    Activity.insert description: 'Added new unit template'
  UnitTemplates.after.remove (userId, doc, fieldNames, modifier, options) ->
    Activity.insert description: "Unit template '#{doc.name}' removed"

  UnitTemplates.before.update (userId, doc, fieldNames, modifier, options) ->
    modifier.$set = modifier.$set || {};
    modifier.$set.modifiedAt = Date.now();
