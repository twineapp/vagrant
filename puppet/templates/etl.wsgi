import sys
sys.path.insert(0, '/var/www/siv-v3/api-data/ETL')

from etl import create_app
application = create_app()