Template.newItemDropdown.events =
  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

  'submit form': (e, template) ->
    e.preventDefault()
    @onSubmit template.$('.new-item').val()

  'show.bs.dropdown': (e, template) ->
    Meteor.defer ->
      template.$('input.new-item').select().focus()
