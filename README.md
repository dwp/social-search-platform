# Social Search Platform

Wrapper project for social-search and slack-api-export to ensure that the projects work as a single platform.  This project has been greated with the aim to then host the entire system on Amazon EC2.

Please checkout this project, copy the ```.env.dist``` file to ```.env``` replacing the parameters are detailed in the slack-api-export project and then run the ```install.sh``` script.

This will then run a docker-compose project which will setup the social search platform consisting of:

* **nginx / php-fpm** Two containers which run the slack-api-export project which pushes data from Slack in to a mongodb database.
* **console** A php console application used to export data, and manualy call the import/export command. 
* **mongo** MongoDB data storage container.
* **socialsearch** A scala API which provides limited AI and search services to answer questions.
* **elasticsearch** An elastic search service used by the social search API.
* **bot** A Botkit slack bot which acts as a basic user interface.

### Deployment

In order to deploy the application you need to have a the SSH credentials installed for an AWS instance.

This means you need to things:

1. An entry in /etc/hosts which aliases ```knowbot``` to the IP address of the server you wish to deploy on.
2. A ~/.ssh/config file which sets the user you are connecting with (should have sudo privileges) and associates the relevant SSH key, an example follows:

```
Host knowbot
    User ubuntu
    IdentityFile ~/Repos/aws/ssh/knowbot-server.pem
```

Then to deploy the application simply run the ./scripts/deploy.sh shell file in this repository.  This process assumes that the server you are deploying to is managed via puppet and has been configured as a knowbot-app node.

You can find out more about the puppet process in [this repository](https://gitlab.itsshared.net/Innovation/puppet).