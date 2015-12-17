#!/bin/bash
brightness=`blshow | colrm 4`
new=`blshow | colrm 3`
if [ $brightness == "100" ]
then
    echo " $brightness""%"
else
    echo " $new""%"
fi
