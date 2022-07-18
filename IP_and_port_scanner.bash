#!usr/bin/bash
R='1 received'
OCT=$(cat oct.txt) #set a variable to have the value of oct.txt
#subnet ip
ifconfig | grep broadcast | awk -F " " '{print $2 }' | cut -d "." -f 1,2,3 | uniq > oct.txt

#create new text file with the name of the octs of the subnet ip
echo " " > $OCT.txt

ping_nmap(){
	  result_of_ping=$(ping -c 1 $OCT.$i)  #ping the ip_address
	if [[ $result_of_ping == *$R* ]] 
		then
      			echo "$OCT.$i" >> $OCT.txt 
			nmap   $OCT.$i> $OCT.$i-nmap.txt #performe nmap scan on devices
	fi 

   }


#loop
for i in {1..254} 
do
	ip_address=$OCT.$i
	ping_nmap $ip_address &
done
echo "done scanning the IPs of devices connected to your network"
reset
