Introduction
============

Docker container for MongoDB 2.x.x with ability to form cluster


Usage
=====

Uses the ability in recent Docker versions to set up hosts entries to locate a node to cluster with. For
convenience sake, the node is named master.


Run 
---

`docker run -d -h mongodb --name mongodb -p 27017:27017 -p 27018:27018 -p 27019:27019 \
			akolosov/mongodb <mongodb options>`
