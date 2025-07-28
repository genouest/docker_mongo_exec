#!/bin/bash

function run_scripts () {
	SCRIPTS_DIR="/scripts/$1.d"
	SCRIPT_FILES_PATTERN="^${SCRIPTS_DIR}/[0-9][0-9][a-zA-Z0-9_-]+$"
	SCRIPTS=$(find "$SCRIPTS_DIR" -type f -uid 0 -executable -regex "$SCRIPT_FILES_PATTERN" | sort)
	if [ -n "$SCRIPTS" ] ; then
		echo "=>> $1-scripts:"
	    for script in $SCRIPTS ; do
	        echo "=> $script"
			. "$script"
	    done
	fi
}



run_scripts pre-launch

# Default to launching mongo if no parameters passed
if [ $# -eq 0 ]; then
	su $MONGO_USER -c 'docker-entrypoint.sh mongod'
else
	su $MONGO_USER -c 'docker-entrypoint.sh mongod > /tmp/mongo.log 2>&1 &'
        /usr/bin/sleep 3600
	exec "$@"
fi
