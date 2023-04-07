NOTES_DIR=${NOTES_DIR:-~/.notes}

[ ! -d $NOTES_DIR ] && mkdir -p $NOTES_DIR;

n() { $EDITOR ${NOTES_DIR}/$*; } 

nls() { lsd -t --blocks name,date ${NOTES_DIR}/ | grep "$*"; }

nr() { rm ${NOTES_DIR}/"$*"; }

ns() { grep -C 5 "$*" ${NOTES_DIR}/*;}

nv() { cat ${NOTES_DIR}/"$*"; }
