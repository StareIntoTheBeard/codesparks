###BEGIN SCRIPT###

###SCRIPT NAME:  scaffold.sh ###

#!/bin/bash

slots=$1
argument1=$2

function scaffold {
if [ -e ./application/controllers/$argument1.php ] ; then                                                            justinbean@Justins-MacBook-Pro
	echo 'That scaffold already exists.'
	exit 0
fi

for i in $argument1; do B=`echo "${i:0:1}" | tr a-z A-Z`${i:1}; done

echo 'Generating scaffold...'
mkdir ./application/views/$argument1  
mkdir ./application/views/$argument1/partials  
touch ./application/views/$argument1/index.php

echo "<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');" >> ./application/controllers/$argument1.php
echo " "  >> ./application/controllers/$argument1.php
echo "class $B extends CI_Controller {" >> ./application/controllers/$argument1.php
echo " " >> ./application/controllers/$argument1.php
echo "public function index()" >> ./application/controllers/$argument1.php
echo "	{ " >> ./application/controllers/$argument1.php
echo "		template();" >> ./application/controllers/$argument1.php
echo "    }" >> ./application/controllers/$argument1.php
echo "}  " >> ./application/controllers/$argument1.php
echo 'Scaffold created!'
}

case "${slots[@]}" in  *"setup"*)
if grep -q '$sparked = true;' ./index.php ; then
	echo 'This application has already been setup.'
	exit 0
fi;
perl -pi -e "s/$sparked = false;/$sparked = true;/g" ./index.php
rm ./application/controllers/sparks.php
rm ./application/views/sparks/index.php
perl -pi -e "s/'sparks'/'$argument1'/g" ./application/config/routes.php
scaffold
;; esac

if [ $# -eq 0 ] ; then
echo "You didn't enter any arguments."
echo "If this is a new project, run ./scaffold.sh setup {new scaffold name} "
echo "If you're just generating new views and controllers, run ./scaffold.sh generate {new scaffold name}"
fi

case "${slots[@]}" in  *"generate"*)
scaffold
;; esac

###END SCRIPT###