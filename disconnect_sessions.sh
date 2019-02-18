printf "\nCreating Session Cleanup\n"
mgmt_cli -r true show sessions limit 500 --format json | jq -r ' .objects[] | "mgmt_cli -s id.txt discard uid " + .uid ' >kill_sessions.txt

sed -i '1s/^/mgmt_cli -r true login > id.txt\n/' kill_sessions.txt
echo "mgmt_cli -s id.txt publish" >> kill_sessions.txt
echo "mgmt_cli -s id.txt logout" >> kill_sessions.txt
chmod +x kill_sessions.txt
echo "You can execute host_set.txt using ./kill_sessions.txt"
