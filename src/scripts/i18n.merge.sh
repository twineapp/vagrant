#!/bin/sh

# create twine.po and twine.mo files by merging core.po and instance.po

# to run manually
#	vagrant ssh
#	. /var/www/vagrant/src/scripts/i18n.merge.sh

# configuration
LOCALES_PATH="/var/www/siv-v3/api/application/language/locales"

# create language specific po files
for LANG in $(find $LOCALES_PATH/. -maxdepth 1 -mindepth 1 -type d -printf '%f ')
do
	# check that core.po and instance.po exists
	if [ -f "$LOCALES_PATH/$LANG/LC_MESSAGES/core.po" -a -f "$LOCALES_PATH/$LANG/LC_MESSAGES/instance.po" ]
	then
		# create twine.po by merging core.po into instance.po 
		echo "creating twine.po for $LANG"
		msgcat $LOCALES_PATH/$LANG/LC_MESSAGES/instance.po $LOCALES_PATH/$LANG/LC_MESSAGES/core.po --sort-output --no-location --use-first --output-file=$LOCALES_PATH/$LANG/LC_MESSAGES/twine.po

		# generate twine.mo
		echo "generating twine.mo for $LANG"
		msgfmt --check --verbose --output-file=$LOCALES_PATH/$LANG/LC_MESSAGES/twine.mo $LOCALES_PATH/$LANG/LC_MESSAGES/twine.po
	else
		echo "ERROR: missing core.po and/or instance.po file for $LANG, unable to generate twine.po and twine.mo"
	fi
done

# restart apache
echo "restarting apache"
sudo apachectl restart

echo "script complete"
exit