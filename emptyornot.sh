#!/bin/bash

echo -e " Enter file Name: \c"
read file

if [ -s $file ]; then
echo " file is not empty"
else
echo " file is empty"
fi

