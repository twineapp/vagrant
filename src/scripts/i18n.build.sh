#!/bin/sh

# build core and instance po files

# to run manually
#	vagrant ssh
#	. /var/www/vagrant/src/scripts/i18n.build.sh

# configuration
DEFAULT_LANGUAGE="en_US"
APPLICATION_PATH="/var/www/siv-v3/api/application"
LOCALES_PATH="/var/www/siv-v3/api/application/language/locales"
INSTANCE_CONFIG="instance.config.php"

# check that instance config exists
if [ ! -f "$APPLICATION_PATH/config/$INSTANCE_CONFIG" ]
then
	echo "ERROR: Instance specific configuration not found! ($APPLICATION_PATH/config/$INSTANCE_CONFIG)"
	exit
fi

# generate core.pot
echo "generating core.pot and instance.pot"
find $APPLICATION_PATH -type f \( -name '*.php' ! -name '$INSTANCE_CONFIG' \)  -print > list
xgettext \
	--copyright-holder="2014 Locsis" \
	--package-name="Twine" \
	--package-version="1.0" \
	--msgid-bugs-address="locsis.webhis@gmail.com" \
	--language=PHP \
	--from-code=UTF-8 \
	--sort-output \
	--no-wrap \
	--force \
	--output-dir=$LOCALES_PATH \
	--output=core.pot \
	--default-domain=core \
	--files-from=list

xgettext \
	--copyright-holder="2014 Locsis" \
	--package-name="Twine" \
	--package-version="1.0" \
	--msgid-bugs-address="locsis.webhis@gmail.com" \
	--language=PHP \
	--from-code=UTF-8 \
	--sort-output \
	--no-wrap \
	--force \
	--output-dir=$LOCALES_PATH \
	--output=instance.pot \
	--default-domain=instance \
	$APPLICATION_PATH/config/$INSTANCE_CONFIG

# create language specific po files
for LANG in $(find $LOCALES_PATH/. -maxdepth 1 -mindepth 1 -type d -printf '%f ')
do
	# check that core.po file doesn't exists, we don't want to overwrite translation unless it's the default language
	if [ ! -f "$LOCALES_PATH/$LANG/LC_MESSAGES/core.po" -o $LANG = $DEFAULT_LANGUAGE ]
	then
		echo "creating core.po for $LANG"
		msginit --no-translator --no-wrap --locale=$LANG.UTF-8 --output-file=$LOCALES_PATH/$LANG/LC_MESSAGES/core.po --input=$LOCALES_PATH/core.pot
	fi

	# check that instance.po file doesn't exists, we don't want to overwrite translation unless it's the default language
	if [ ! -f "$LOCALES_PATH/$LANG/LC_MESSAGES/instance.po" -o $LANG = $DEFAULT_LANGUAGE ]
	then
		echo "creating instance.po for $LANG"
		msginit --no-translator --no-wrap --locale=$LANG.UTF-8 --output-file=$LOCALES_PATH/$LANG/LC_MESSAGES/instance.po --input=$LOCALES_PATH/instance.pot
	fi

	# merge new pot templates with existing po files
	echo "updating core.po for $LANG"
	msgmerge --sort-output --no-wrap --update --no-fuzzy-matching --backup=off $LOCALES_PATH/$LANG/LC_MESSAGES/core.po $LOCALES_PATH/core.pot
	# remove fuzzy translations
	msgattrib --no-fuzzy -o $LOCALES_PATH/$LANG/LC_MESSAGES/core.po $LOCALES_PATH/$LANG/LC_MESSAGES/core.po
	echo "updating instance.po for $LANG"
	msgmerge --sort-output --no-wrap --update --no-fuzzy-matching --backup=off $LOCALES_PATH/$LANG/LC_MESSAGES/instance.po $LOCALES_PATH/instance.pot
	# remove fuzzy translations
	msgattrib --no-fuzzy -o $LOCALES_PATH/$LANG/LC_MESSAGES/instance.po $LOCALES_PATH/$LANG/LC_MESSAGES/instance.po
done

echo "removing core.pot and instance.pot"
rm -f "$LOCALES_PATH/core.pot"
rm -f "$LOCALES_PATH/instance.pot"

echo "script complete"
exit