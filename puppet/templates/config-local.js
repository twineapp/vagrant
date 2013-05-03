define('config-local',function(){
	// Local Configuration overrides
	var c = {
		hostname: 'http://' + window.location.host,
		logoPath: 'assets/images/logos/siv-logo-demo.png',
		headerClass: 'siv-header-demo',
		appTitle: 'twine',
		googleClientId: '',
		yahooClientId: '',
		facebookClientId: ''
	}

	return c;
})
