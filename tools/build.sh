#!/bin/bash
#
# Build jekyll site and store site files in ./_site
# v2.0
# https://github.com/cotes2020/jekyll-theme-chirpy
# © 2019 Cotes Chung
# Published under MIT License

set -eu

CMD="JEKYLL_ENV=production bundle exec jekyll b"

WORK_DIR=$(dirname $(dirname $(realpath "$0")))

CONTAINER=${WORK_DIR}/.container

DEST=${WORK_DIR}/_site


_help() {
  echo "Usage:"
  echo
  echo "   bash build.sh [options]"
  echo
  echo "Options:"
  echo "   -b, --baseurl <URL>      The site relative url that start with slash, e.g. '/project'"
  echo "   -h, --help               Print the help information"
  echo "   -d, --destination <DIR>  Destination directory (defaults to ./_site)"
}


_init() {
echo ">>>>>>>>>>>>>>In init 1!"
  cd $WORK_DIR

echo ">>>>>>>>>>>>>>In init 2!"
  if [[ -d $CONTAINER ]]; then
echo ">>>>>>>>>>>>>>In init 3!"
    rm -rf $CONTAINER
  fi

echo ">>>>>>>>>>>>>>In init 4!"
  if [[ -d _site ]]; then
echo ">>>>>>>>>>>>>>In init 5!"
    bundle exec jekyll clean
  fi
echo ">>>>>>>>>>>>>>In init 6!"

  local _temp=$(mktemp -d)
echo ">>>>>>>>>>>>>>In init 7!"
  cp -r * $_temp
echo ">>>>>>>>>>>>>>In init 8!"
  cp -r .git $_temp
echo ">>>>>>>>>>>>>>In init 9!"
  mv $_temp $CONTAINER
echo ">>>>>>>>>>>>>>In init 10!"
}


_build() {
  cd $CONTAINER
  echo "$ cd $(pwd)"

  bash _scripts/sh/create_pages.sh
  bash _scripts/sh/dump_lastmod.sh

  CMD+=" -d ${DEST}"
  echo "\$ $CMD"
  eval $CMD
  echo -e "\nBuild success, the site files have been placed in '${DEST}'."

  if [[ -d ${DEST}/.git ]]; then
    if [[ ! -z $(git -C $DEST status -s) ]]; then
      git -C $DEST add .
      git -C $DEST commit -m "[Automation] Update site files." -q
      echo -e "\nPlease push the changes of $DEST to remote master branch.\n"
    fi
  fi

  cd .. && rm -rf $CONTAINER
}


_check_unset() {
  if [[ -z ${1:+unset} ]]
  then
    _help
    exit 1
  fi
}


main() {
  while [[ $# -gt 0 ]]
  do
    opt="$1"
    case $opt in
      -b|--baseurl)
        _check_unset $2
        if [[ $2 == \/* ]]
        then
          CMD+=" -b $2"
        else
          _help
          exit 1
        fi
        shift
        shift
        ;;
      -d|--destination)
        _check_unset $2
        DEST=$(realpath $2)
        shift;
        shift;
        ;;
      -h|--help)
        _help
        exit 0
        ;;
      *) # unknown option
        _help
        exit 1
        ;;
    esac
  done

echo ">>>>>>>>>>>>>>Before init!"
  _init
echo ">>>>>>>>>>>>>>Before build!"
  _build
echo ">>>>>>>>>>>>>>End of main!"
}

main "$@"
