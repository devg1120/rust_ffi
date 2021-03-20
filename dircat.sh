

usage_exit() {
#        echo "Usage: $0 [-a] [-d dir] item ..." 1>&2
        echo "Usage: $0 [-f]  item ..." 1>&2
        exit 1
}

FILE_BODY=1
while getopts fah OPT
do
    case $OPT in
        f)  FILE_BODY=0
            ;;
#        d)  VALUE_D=$OPTARG
#            ;;
        h)  usage_exit
            ;;
        \?) usage_exit
            ;;
    esac
done

shift $((OPTIND - 1))

#----------------------------------------------------------
print_filename(){
  NAME=$1
  LENGTH=${#NAME}
  ADD_LENGTH=$(( 80 - $LENGTH  ))
  if [ $FILE_BODY -eq 1 ]; then
    echo ''
    for((i=0;i<$ADD_LENGTH;i++));do echo -n '-';done
    echo ' ' $NAME
    echo ''
  else
    echo ' ' $NAME
  fi

}
print_title(){
  NAME=$1
  LENGTH=${#NAME}
  ADD_LENGTH=$(( $LENGTH + 11 ))
  
  #for((i=0;i<$ADD_LENGTH;i++));do echo -n '*';done
  #echo '*'
  #echo "**** "   $NAME   " ****"
  #for((i=0;i<$ADD_LENGTH;i++));do echo -n '*';done
  #echo '*'
  echo "# "   $NAME   
}

print_memo() {
  #echo "subdir--" $1
  DIR=$1
  if [ $FILE_BODY -eq 1 ]; then
    #echo "> " $DIR
    #echo -n "> "
    while read line
    do
      #echo "> " $line
      echo   $line
    done < $DIR
  fi
  echo ""
  #if [ -f $DIR/MEMO.txt ]; then
  #  echo "## MEMO"

  #fi
}

find_subdir() {
  #echo "subdir--" $1
  DIR=$1

  #----------------------------------  file operation
  for subdir in ${DIR}/*; do
#    if [ -d "$subdir" ]; then
#      if [ $subdir = "./node_modules" ]; then
#         continue
#      fi
#      if [ $subdir = "./e2e" ]; then
#         continue
#      fi
#
#      echo "" ["$subdir" "]"
#      find_subdir $subdir
#    fi
    if [ -f "$subdir" ]; then
      if [[ $subdir =~ .*\.tgz$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.tar$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.zip$ ]]; then  
         continue
      fi
      if [[ $subdir =~ .*\.ico$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.png$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.cat$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.md$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.exe$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.md$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.o$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.a$ ]]; then
         continue
      fi
      if [[ $subdir =~ .*\.so$ ]]; then
         continue
      fi
      if [ $subdir = "./dircat.sh" ]; then
         continue
      fi
      if [[ $subdir =~ MEMO\.txt ]]; then
      #if [[ $subdir =~ MEMO\.md ]]; then
         print_memo $subdir
         continue
      fi
      #echo " " "$subdir" 
      print_filename $subdir 
      if [ $FILE_BODY -eq 1 ]; then
        if [[ $subdir =~ .*\.c$ ]]; then
           echo "\`\`\`c"
        elif [[ $subdir =~ .*\.rs$ ]]; then
           echo "\`\`\`rust"
        elif [[ $subdir =~ .*\.sh$ ]]; then
           echo "\`\`\`sh"
        else
           echo "\`\`\`"
        fi
        cat $subdir
        echo "\`\`\`"
      fi
    fi
  done

  #----------------------------------  directory operation
  for subdir in ${DIR}/*; do
    if [ -d "$subdir" ]; then
      if [ $subdir = "./node_modules" ]; then
         continue
      fi
      if [ $subdir = "./e2e" ]; then
         continue
      fi

      echo ""# ["$subdir" "]"
      #if [ $FILE_BODY -eq 1 ]; then
      #    print_memo $subdir
      #fi
      find_subdir $subdir
    fi
#    if [ -f "$subdir" ]; then
#      if [[ $subdir =~ .*\.zip$ ]]; then
#         continue
#      fi
#     if [[ $subdir =~ .*\.ico$ ]]; then
#         continue
#      fi
#      if [ $subdir = "./package-lock.json" ]; then
#         continue
#      fi
#      #echo " " "$subdir"
#      print_filename $subdir
#      if [ $FILE_BODY -eq 1 ]; then
#        cat $subdir
#      fi
#    fi
  done
}


TPATH='.'
FULL_PATH=${PWD}

NAME=$(basename $FULL_PATH)

print_title $NAME

if [ $FILE_BODY -eq 0 ]; then
    find_subdir $TPATH
else
    FILE_BODY=0
    echo "\`\`\`"
    find_subdir $TPATH
    echo "\`\`\`"
    FILE_BODY=1
    find_subdir $TPATH

fi
