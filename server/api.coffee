Router.map ->
  @route 'apiControlUnit',
    path: '/api/unit/:name'
    where: 'server'
    action: ->
      if @request.method == 'PUT'
        [unitName, action] = [@params.name, @request.body.action]
        Fleet["#{action}Unit"] unitName
        @response.writeHead 200, 'Content-Type': 'text/plain'
        @response.end "Scheduled to #{action} #{unitName}."
      else
        @response.writeHead 405, 'Content-Type': 'text/plain'
        @response.end "#{@request.method} requests are not allowed for this resource."
  @route 'apiCreateUnit',
    path: '/api/unit'
    where: 'server'
    action: ->
      if @request.method == 'POST'
        [unitName, unitCode] = [@request.body.name, @request.body.code]
        Fleet.submitUnit unitName, unitCode
        @response.writeHead 200, 'Content-Type': 'text/plain'
        @response.end "Submitted #{unitName}."
      else
        @response.writeHead 405, 'Content-Type': 'text/plain'
        @response.end "#{@request.method} requests are not allowed for this resource."
  