download:
	wget https://www.dropbox.com/s/tkwde2rzjappfta/lodstats.nt.gz -O toLoad/lodstats.nt.gz && gunzip toLoad/lodstats.nt.gz
	wget https://www.dropbox.com/s/xszbuq2fnj9z9x3/lodstats_dump_13-09-2017_17_20_05.sql.gz -O db/lodstats_dump.sql.gz && gunzip db/lodstats_dump.sql.gz

restart:
	docker stop lodstatsdocker_lodstats-web_1 && docker rm lodstatsdocker_lodstats-web_1	
	docker-compose up -d
