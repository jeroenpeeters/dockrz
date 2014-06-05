Template.registry.events =

 'click .newContainer': (e, template)->
    console.log 'newContainer', @
    $('#myModal .name').html(@Id)
