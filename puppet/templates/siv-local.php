<?php  if ( ! defined( 'BASEPATH' ) ) exit( 'No direct script access allowed' );
/*
| -------------------------------------------------------------------------
| Server specific CI api config file, gitignored
| Place this file here: siv-v3/api/application/config/
| Lasted changed 20121214 JB
| -------------------------------------------------------------------------
*/

/*
| -------------------------------------------------------------------------
| Databases
| -------------------------------------------------------------------------
*/

// mySQL
$config['databases']['app'] 				= 'siv_app';
$config['databases']['data'] 				= 'siv_data';
$config['databases']['staging']				= 'siv_staging';
$config['databases']['users']				= 'siv_users';

/// mongoDB
$config['databases']['his_data']			= 'siv';

/*
| -------------------------------------------------------------------------
| Users
| -------------------------------------------------------------------------
*/

/*
| -------------------------------------------------------------------------
| OAuth settings
| -------------------------------------------------------------------------
|
*/


/*
| -------------------------------------------------------------------------
| Database Settings
| -------------------------------------------------------------------------
*/

// prod settings
$config['api']['display_db_errors'] = FALSE;
$config['api']['log_db_errors'] = TRUE;


// mySQL public
$db['mysql']['public']['username'] 			= 'siv_read';
$db['mysql']['public']['password'] 			= 'siv_pwd1';
$db['mysql']['public']['database'] 			= $config['databases']['data'];

// mySQL admin
$db['mysql']['admin']['username'] 			= 'siv_write';
$db['mysql']['admin']['password'] 			= 'siv_pwd2';
$db['mysql']['admin']['database'] 			= $config['databases']['data'];

// mongoDB public
$db['mongo']['public']['mongo_user'] 		= NULL;
$db['mongo']['public']['mongo_pass'] 		= NULL;
$db['mongo']['public']['mongo_db'] 			= $config['databases']['his_data'];

// mongoDB admin
$db['mongo']['admin']['mongo_user'] 		= NULL;
$db['mongo']['admin']['mongo_pass'] 		= NULL;
$db['mongo']['admin']['mongo_db'] 			= $config['databases']['his_data'];

$config['api']['pdf_docraptor']						= FALSE; //forces use of docraptor service instead of PrinceXML for pdf creation

/*
| -------------------------------------------------------------------------
| API settings
| -------------------------------------------------------------------------
|
*/
$config['api']['performance']				= FALSE;

// error/debug logging
$config['api']['log_errors']				= FALSE; // API Fatal errors
$config['api']['errors_to_log']				= array(2005, 2006, 2007); // array of error codes to log, empty array logs all errors
$config['api']['log_debug']					= TRUE; // Non-API errors (supressed errors)
$config['api']['email_debug_group']			= 16;

/*
| -------------------------------------------------------------------------
| SMSsync Secret Key
| -------------------------------------------------------------------------
*/
$config['smssync_secret_key']			= '';


/*
| -------------------------------------------------------------------------
| Filestore
| -------------------------------------------------------------------------
*/
$config['files']['filestore']['location']						= 'local'; //'location' can be 'local', 'dropbox'. This determines where to look for files to retrieve.
//if filestore is local
$config['files']['location']['local']['path_from_root']		= '/var/www/siv-v3/filestore';
$config['files']['filestore']['backup_file_path']				= NULL;

/*
| -------------------------------------------------------------------------
| Email Settings
| -------------------------------------------------------------------------
*/
$config['email']['send'] 					= FALSE;

/* End of file siv-local.php */
/* Location: ./application/config/siv-local.php */
