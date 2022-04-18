private_key="<Paste Private key path here>"
config_file="./connections.properties"
separators='=,;'

function goto ()
{
    label=$1
    cmd=$(sed -n "/$label:/{:a;n;p;ba};" $0 | grep -v ':$')
    eval "$cmd"
    exit
}
goto ${1:-"START"}

START:
echo "Use below <number> => <host> mapping to connect"
while IFS=$separators read -r number host user;
do
	echo "$number => $host as $user"
done < "$config_file"
echo "==================================================================="

USER_INPUT:
read -p "Enter Host Number: " host_num

while IFS=$separators read -r number host user
do
	if [ $number == $host_num ]
	then
		goto CONNECT_COMMAND
	fi	
done < "$config_file"

echo "Invalid Input!"
goto USER_INPUT

CONNECT_COMMAND:
ssh $user@$host -i $private_key
