printf "\nWhat is the IP address or Name of the Domain or SMS you want to check?\n"
read DOMAIN

printf "\nCreating Session Cleanup\n"
mgmt_cli -r true -d $DOMAIN show sessions limit 500 --format json | jq -r ' .objects[] | "mgmt_cli -s id.txt discard uid " + .uid ' >kill_sessions.txt

sed -i '1s/^/mgmt_cli -r true login > id.txt\n/' kill_sessions.txt
echo "mgmt_cli -s id.txt publish" >> kill_sessions.txt
echo "mgmt_cli -s id.txt logout" >> kill_sessions.txt
chmod +x kill_sessions.txt
echo "You can execute host_set.txt using ./kill_sessions.txt"
