#!/usr/bin/env bash

set_vault() {
  source <(ops run vault --user markus |grep export | tr -d '\r')
  op item edit "Axial - Vault" password="$VAULT_TOKEN" --url $VAULT_ADDR
}

#Disabled
return

## Requires: nvm
FNAME=~/.vaultrc
if [ ! -f "$FNAME" ] ; then
	touch -d 20120101 $FNAME
fi

if [[ $(find "$FNAME" -mmin +1200 -print) ]]; then
	rm -f $FNAME
	ops run vault --user markus |grep export | tr -d '\r'  > $FNAME
fi

. $FNAME

