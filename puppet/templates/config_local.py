"""
	Local configuration overrides, enter settings here that would like overriden in config.py for the application
"""

configuration = {
	# Debugging
	"debug": True,
	"api_debug": True,
	
	# API Authentication
	# Header - Authorization: twine_token: "THE_API_KEY"
	"api_token": "THIS_IS_MY_API_KEY",
	"enforce_token": False,

	# Databases
	"servers": {
		"public": {
			"username": "root",
			"password": "password"
		},
		"admin": {
			"username": "root",
			"password": "password"
		},
		"his_data": {
			"username": "admin",
			"password": "admin"
		}
	},
	"databases": {
		"his_data":	"siv"
	},
	"collections": {
		"his": 		"his",
		"de_urban":	"de_urban"
	}
}
