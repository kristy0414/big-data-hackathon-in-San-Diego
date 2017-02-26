import psycopg2


try:
    conn_string="host='127.0.0.1' dbname='Final_Project' user='RickZhang_admin' password='47795081'"
    print "Connecting to database\n ->%s" % (conn_string)
    conn = psycopg2.connect(conn_string)
    print conn
    cursor=conn.cursor()
    print "Database Connected!"

    place_name=raw_input("Please type the place name you want to query:")
    file_name=raw_input("Please type the file name:")
    cursor.execute("create table tweet_"+file_name+" as select id,text,username,longtitude,latitude,created_at_local,source_clean from tweets.whole_tweets_clean where text LIKE '%"+place_name+"%'")
    cursor.execute("copy tweet_"+file_name+" to 'I:/Dropbox/bigdata_hackathon/data/social_media_data/"+file_name+".csv' WITH CSV HEADER" )


except Exception, e:
    print("Connection to '%s'@'%s' failed.")
    print(e)