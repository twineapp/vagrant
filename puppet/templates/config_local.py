"""
	Local configuration overrides, enter settings here that would like overriden in config.py for the application
"""

configuration = {
	# Debugging
	"debug": True,
	"api_debug": True,
	"log_finished_report": False,

	"threading": False,
	
	# API Authentication
	# Header - Authorization: twine_token: "THE_API_KEY"
	"api_token": "THIS_IS_MY_API_KEY",
	"enforce_token": False,

	### Servers ###
	"servers": {
            "mongo": {
                # List the driver
                "driver": 	"mongo",
                # the host
                "host": 	"localhost",
                # The port used to connect
                "port": 	None,
                # The username
                "username":     "admin",
                # The password
                "password":     "admin",
                # What databases are available on this server
                "databases":    ["siv"]
            },
            "production": {
                "driver":       "mysql",
                "host":         "localhost",
                "port":         27017,
                "username":     "root",
                "password":     "pwd",
                "databases":    ["data", "app", "users"]
            }
	},
}
