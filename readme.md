# Social Search Platform

Wrapper project for social-search and slack-api-export to ensure that the projects work as a single platform.  This project has been greated with the aim to then host the entire system on Amazon EC2.

Please checkout this project, copy the ```.env.dist``` file to ```.env``` replacing the parameters are detailed in the slack-api-export project and then run the ```install.sh``` script.

This will then run a docker-compose project which will setup the social search platform consisting of:

* **nginx / php-fpm** Two containers which run the slack-api-export project which pushes data from Slack in to a mongodb database.
* **console** A php console application used to export data, and manualy call the import/export command. 
* **mongo** MongoDB data storage container.
