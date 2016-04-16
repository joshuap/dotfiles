# See http://docs.datastax.com/en/cassandra/2.0/cassandra/install/installDeb_t.html

echo "Writing /etc/apt/sources.list.d/cassandra.sources.list ..."
echo "deb http://debian.datastax.com/community stable main" | sudo tee -a /etc/apt/sources.list.d/cassandra.sources.list

echo "Importing repository signing key for debian.datastax.com..."
curl -L http://debian.datastax.com/debian/repo_key | sudo apt-key add -
