Template.images.events =

  'click .createContainer': (e, template)->
    name = $('.containerName', e.target.parentNode).val()
    Meteor.call 'createContainer', @Id, name, Session.get('dockerEndpoint')

  'click .dropdown-menu': (e) -> e.stopPropagation() unless e.target.tagName.toUpperCase() == 'BUTTON'
  
  'input #imageFilter': (e, tpl) -> Session.set 'imageFilter', tpl.$('#imageFilter').val()
