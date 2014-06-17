@Machines = new Meteor.Collection 'machines'
@Units = new Meteor.Collection 'units'
@UnitTemplates = new Meteor.Collection 'unitTemplates'

UnitTemplates.allow {
  insert: (userId, doc) -> true
  update: (userId, doc, fields, modifier) -> true
  remove: (userId, doc) -> true
}