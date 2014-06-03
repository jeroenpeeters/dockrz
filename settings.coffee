@settings =
  docker:
    endpoints: [
      'http://docker1.rni.org:4243',
      'http://docker2.rni.org:4243',
      'http://docker3.rni.org:4243',
      'http://docker4.rni.org:4243',
      'http://docker5.rni.org:4243',
      'http://docker6.rni.org:4243']

  fleet:
    endpoint: 'ssh rni@docker-cluster.rni.org -p 443 '
