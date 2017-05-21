# Shell
cdn() {
  for i in `seq $1`;
    do cd ..;
  done;
}

alias editHosts='sudo edit /etc/hosts'

# Search
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Find files, that start with, end with, or contain...
ff () { /usr/bin/find . -name "$@" ; }
ffs () { /usr/bin/find . -name "$@"'*' ; }
ffe() { /usr/bin/find . -name '*'"$@" ; }
ffc() { /usr/bin/find . -name '*'"$@"'*' ; }


# Extract
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
 }

# Java
jvm() {
  export JAVA_HOME=`/usr/libexec/java_home -v "$1"`
  java -version
}

# Docker
dc() {
  if [[ $@ == "up" ]]; then
    docker-compose up -d
  elif [[ $@ == "down"  ]]; then
    docker-compose down
  elif [[ $@ == "build" ]]; then
    docker-compose build;
  elif [[ $@ == "remove" ]]; then
    docker stop $(docker ps -a -q)
    wait %1
    docker rm $(docker ps -a -q)
  elif [[ $@ == "rebuild" ]]; then
    dc remove & make
    wait %1 %2
    dc up
  fi
}
