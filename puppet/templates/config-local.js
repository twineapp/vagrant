define('config-local',function(){
	// Local Configuration overrides
	var c = {
		hostname: 'http://' + window.location.hostname + ':8081',
		logoPath: 'assets/images/logos/siv-logo-demo.png',
		headerClass: 'siv-header-demo',
		appTitle: 'twine',
		googleClientId: '',
		yahooClientId: '',
		facebookClientId: ''
	}

	return c;
})
