#!/bin/sh

# start mysql
mysqld_safe&

# start nginx
nginx&

# start forever
NODE_ENV=production npm start --sourceDir /var/www index.js

