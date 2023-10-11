

#!/bin/bash



# Define the MySQL port

MYSQL_PORT=${MYSQL_PORT_NUMBER}



# Check if any other services are using the MySQL port

if sudo lsof -i :$MYSQL_PORT | grep -q LISTEN; then

    # If so, prompt the user to stop those services

    echo "Other services are using port $MYSQL_PORT. You may need to stop those services to start MySQL."

else

    # Otherwise, MySQL can be started without issue

    echo "MySQL can be started."

fi