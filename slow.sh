#!/bin/csh
clear
echo "-----------------"
echo "------SLOW-------"
echo "-----------------"

set currentnice="`ps -o ni -p $$`"
set realcurrent = 0
@ realcurrent = $currentnice[2] + 20
echo "nice courant: $realcurrent"

set cmd1 = "`ps -ax -o user,pid,ppid`"
set cmd2 = "`ps -ax -o ni`"
set cmd3 = "`ps -ax -o ppid`"
set cmd4 = "`ps -ax -o command | sed 's/\[//g' | sed 's/\]//g' `"

set cpt=2
set nicecmp=0
@ nicecmp = $currentnice[2]
set nice1=0
set realnice = 0
echo NI $cmd1[1] PARENTUSER COMMAND 

while($cpt < $#cmd1)

    @ nice1 = $cmd2[$cpt]
	set cmd5 = "`ps -ax -p $cmd3[$cpt] -o user`"
	if ($cmd3[$cpt] == 0) then

		set cmd5[2] = "-----"
	endif
	
    @ realnice = $cmd2[$cpt] + 20

    if ($nice1 <= $nicecmp) then

       echo $realnice $cmd1[$cpt] $cmd5[2] $cmd4[$cpt]

    endif

    @ cpt ++

end

set cmd1="`ps -x -o ni`"
set cmd2="`ps -x -o pid`"
set cmd3="`ps -x -o user`"
set cpt=2
set nice2 = 0
set test = 0
while($cpt < $#cmd3)

	@ nice2 = $cmd1[$cpt]
	
	if($nice2 < $nicecmp) then
			(renice $currentnice[2] $cmd2[$cpt] >> stdout) >& stderr
	endif

@ cpt ++
end
cat stdout
cat stderr
rm stdout
rm stderr
echo "Terminé"
