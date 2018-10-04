#!/bin/bash
#
# $Id$
#
NAME=tellico2html

if [ "_$PREFIX" != "_" ]; then
	target=${DESTDIR}$PREFIX
else
	target=${DESTDIR}/usr/local
	echo $PATH | grep $target/bin > /dev/null || echo "Warning - your PATH environmental variable is BROKEN. Please add $target/bin to your PATH."
fi

echo "tellico2html will be installed under $target"

MANDIR=$target/share/man/man1
DATADIR=$target/share/$NAME
BINDIR=$target/bin

echo "Creating target directories ..."
install -m 755 -d $MANDIR $BINDIR $DATADIR/$NAME/examples

echo "Copying files ..."
install -m 0755 $NAME $BINDIR
pod2man -c "tellico2html" --section=1 $BINDIR/$NAME > $MANDIR/$NAME.1
chmod 644 $MANDIR/$NAME.1
cp -a examples/* examples/.??* $DATADIR/$NAME/examples
exit 0
