![Dockrz Logo][logo]

Awesome frontend for [CoreOS](https://coreos.com/), [Fleet](https://github.com/coreos/fleet) & [Docker](https://www.docker.io/) built with [Meteor](https://www.meteor.com/)!

[logo]: https://raw.githubusercontent.com/jeroenpeeters/dockrz/master/public/logo.png "Logo"


Installation
============

Dockrz requires Meteor and Meteorite to be installed. 

- [Meteor Website](https://www.meteor.com/)
- [Meteorite Website](https://github.com/oortcloud/meteorite/)

Clone this repo, or download it as a zip from Github. Go to the directory in which you cloned the Dockrz repository and execute

  `mrt`
  
After downloading the required dependencies the application will start.

Configuration
=============

Dockrz can be configured through the *settings.coffee* file found in the root of the project. Allthough the options are self-explanatory here's a list of what you can configure

- Endpoints for each Docker machine
- An endpoint for the Docker registry
- One endpoint for the fleet cluster
