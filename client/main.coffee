Router.configure
  layoutTemplate: 'layout'

Router.map ->
  @route 'home', 
    path: '/'
    data: 
      images: Images.find()
  @route 'images', 
    path: '/images'
    data: 
      images: Images.find()
      activeImages: class:"active"
  @route 'containers', 
    path: '/containers'
    data: 
      containers: Containers.find()
      activeContainers: class:"active"
