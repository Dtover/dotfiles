#!/bin/bash
# a simple daily to_do list script
if [[ -f "$(date '+%m_%d')" ]];then
	echo "The todo list for $(date '+%m/%d') already exists!"
	while true
	do
		echo -n "What do you want ?(1 to add/2 to change or delete/3 to overwrite)"
		read ans
		case $ans in
			1) 
				let taskid=$(cat $(date '+%m_%d') | wc -l)
				break;;
			2) 
				Maxid=$(cat $(date '+%m_%d') | wc -l)
				while true
				do
					cat $(date '+%m_%d')
					echo -n "Which task you want to change?(input the task id, return means exit)"
					read taskidc
					[[ -z $taskidc ]] && exit;
					if [[ $taskidc -le 0 || $taskidc -gt $Maxid ]];then
						 echo "wrong id!"
						 continue
				 	else
						echo -n "Change task-$taskidc to: (return to delete)"
						read newtask
						if [[ -z $newtask ]];then
							newtask=CANCELED 
							sed -i "$taskidc"c\\""$taskidc"  $newtask" $(date '+%m_%d')
							echo "already delete!"
							exit;
						fi
						echo -n "input new deadline: (return means no deadline)"
						read newdl
						if [[ -z "$newdl" ]];then
							sed -i "$taskidc"c\\"$(printf "%-2s %-20s" "$taskidc" "$newtask")" $(date '+%m_%d')
						else
							sed -i "$taskidc"c\\"$(printf "%-2s %-20s [%s]" "$taskidc" "$newtask" "$newdl")" $(date '+%m_%d')
						fi
						echo "Changed successfully!"
					fi
				done
				break;;
			3) echo 
				echo -n "" > $(date '+%m_%d')
				echo "List clear!"
				taskid=0
				break;;
			*) echo "no such choice!";;
		esac
	done
else
	touch "$(date '+%m_%d')"
	taskid=0
fi
while true
do
	echo -n "Input you task name: (input "1" to see the exists tasks)"
	read task
	if [[ -z "$task" ]];then
		echo "list builded successfully!"
		cat $(date '+%m_%d')
		exit 0;
	elif [[ "$task" = "1" ]];then
		cat $(date '+%m_%d')
	else
		((taskid++))
		echo -n "Input the deadline: (return means no deadline)"
		read deadline
		if [[ -n "$deadline" ]];then
			printf "%-2s %-20s [%s]\n" "$taskid" "$task" "$deadline" >> $(date '+%m_%d')
		else
			printf "%-2s %-20s\n" "$taskid" "$task" >> $(date '+%m_%d')
		fi
	fi
done
