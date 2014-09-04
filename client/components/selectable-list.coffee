Template.selectableList.events =
  'click .list-group-item': -> Session.set @ctx.sessionVar, @item._id
  'click .remove-item': -> @ctx.removeItem @item._id

Template.selectableList.helpers
  active: ->
    if @item._id == Session.get(@ctx.sessionVar) then "active" else ""