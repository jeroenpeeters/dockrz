Template.unitTemplates.events =
  'click .unit-template': -> Session.set 'selectedUnitTemplateId', @_id

  'click #addUnitTemplate': ->
    Session.set 'selectedUnitTemplateId', UnitTemplates.insert {name: "_ Brand new unit", source: "Put unit code here"}

  'click .remove-template': -> UnitTemplates.remove _id: @_id

  'input #templateCode': (e, template) -> UnitTemplates.update {_id: @_id}, {$set: {source: e.target.value}}

  'input #templateName': (e, template) -> UnitTemplates.update {_id: @_id}, {$set: {name: e.target.value}}

Template.unitTemplates.helpers
  active: -> if @_id == Session.get('selectedUnitTemplateId') then "active" else ""
  lastChanged: -> moment(@modifiedAt).fromNow()
