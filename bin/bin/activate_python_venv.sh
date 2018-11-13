#! /usr/bin/env zsh
source .venv/bin/activate

reset_django_project(){
  find . -path '*/migrations/*' -not -name '__init__.py' -not -path '*/.venv*' -or -iname 'db.sqlite3'
  echo '\nDelete these files? [Y/n]'
  read confirmation

  case $confirmation in 
  y|Y|'')
    find . -path '*/migrations/*' -not -name '__init__.py' -not -path '*/.venv*' -or -iname 'db.sqlite3' -delete
    echo 'Deleted.'
    ;;
  *)
    echo 'Canceled.'
    ;;
  esac
}

alias deactivate='deactivate && unalias deactivate && unset -f reset_django_project'
