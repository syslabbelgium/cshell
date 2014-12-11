#!/bin/csh

foreach file($*)

echo "************Lien $file*************" >> stdout if(-e $file) then

	if(-d $file) then
		echo "Repertoire $file :" >> stdout
		if(-r $file) then
			echo "Accès en lecture" >> stdout
			(ls -aul $file >> stdout) >& stderr
		else
			echo "Pas d'accès" >> stdout
		endif	
	
	else

	if(-r $file) then
		
		echo "Lien(s) synonyme(s): " >> stdout
		(ls -RailF | grep @ | grep $file >> stdout) >& stderr
		(ls -Railf $file >> stdout) >& stderr
		echo "Les 5 premières lignes" >> stdout
		(head -n 5 "$file" >> stdout) >& stderr
	else
		echo "Fichier non lisible" >> stdout
	endif
	endif
else

	echo "Lien $file inexistant" >> stdout

endif
end

cat stdout | more
rm stdout >& stderr
rm stderr
