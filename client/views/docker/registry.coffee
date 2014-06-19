Template.registry.events =

 'click .pullImageButton': (e, template)->
    selector =  $(e.currentTarget).closest('tr').find('.tagSelector option:selected')
    $(e.currentTarget).closest('tr').find('.tag').text selector.text()

 'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'

 'click .pullImage': (e, template)->
    name = $('.containerName', e.target.parentNode).val()
    endpoint = $('.endpoint', e.target.parentNode).val()
    tag =  $(e.currentTarget).closest('tr').find('.tagSelector option:selected').text()
    Meteor.call 'createImage',  @name.split('/')[1], tag, endpoint

Template.registry.isSelected = -> "#{@}" == Session.get 'dockerEndpoint'
