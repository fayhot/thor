#!/bin/sh
export THORPATH=$HOME/.f
export THORDEFAULT=fayhot

#@doc http://stackoverflow.com/questions/10942919/customize-tab-completion-in-shell
function _completepins() {
  local cur=${COMP_WORDS[COMP_CWORD]}
  #local pinlist=$(ls $THORPATH -l | grep ^l | awk '{print $9}')
  local pinlist=$(find $THORPATH -type l -printf "%f ")
  if [[ $COMP_CWORD -eq 1 ]]; then
    COMPREPLY=($(compgen -W '${pinlist}' -- "$cur"))
  fi;
  return 0
}

function _init () {
  [ -d ${THORPATH=${THORPATH:-~/.f}} ] || {
    #mkdir -p $THORPATH && complete -F _completepins thor || return 1
    mkdir -p $THORPATH || return 1
  }
  return 0
}

function thor () {
  _init
  while [ $# -ne 0 ]; do
    case $1 in
      -l)ls -l ~/.f/ | grep ^l |  awk '{print $9,"-->",$11}'
         shift
         break
         ;;
      -a)if [ $# -lt 2 ]; then
           echo "Error. expected a pin word"
         fi
         local cmd=$2
         if [ -z $cmd ]; then
           cmd=$THORDEFAULT
         fi
         rm -f $THORPATH/$cmd
         ln -s $PWD $THORPATH/$cmd
         shift
         break
         ;;
      -r)local cmd=$2
         if [ -z $cmd ]; then
           cmd=$THORDEFAULT
         fi
         rm -f $THORPATH/$cmd
         shift
         break
         ;;
      *)local cmd=$1
         if [ -z $cmd ]; then
           cmd=$THORDEFAULT
         fi
         target=`ls -l ~/.f | awk '{print $9, $0}' | grep ^"$cmd" | awk '{print $12}'`
         if [ -z $target ]; then
           echo "not match pin: $cmd"
         else
           cd $target 2>/dev/null
         fi
         return 0
         ;;
    esac
    shift
  done
}

complete -F _completepins thor t
