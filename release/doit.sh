#!/bin/sh

echo "Here comes the good stuff"

TYPE=SGS

cd release && {

mkdir -p ${TYPE} || exit 1

REL=${TYPE}_$(date +%Y%m%d)_NoFrills_boot.zip

	rm -r system 2> /dev/null
	mkdir  -p system/lib/modules || exit 1
	mkdir  -p system/lib/hw || exit 1
	mkdir  -p system/etc/init.d || exit 1
	cd ../
		find . -name "*.ko" -exec cp {} release/system/lib/modules/ \; 2>/dev/null || exit 1
	cd release
	cp 90screenstate_scaling system/etc/init.d/ || exit 1
	cp S98system_tweak system/etc/init.d/ || exit 1
	zip -q -r ${REL} system boot.img META-INF script bml_over_mtd bml_over_mtd.sh || exit 1
	sha256sum ${REL} > ${REL}.sha256sum
	mv ${REL}* ${TYPE} || exit 1
} || exit 1

rm system/lib/modules/*
rm system/etc/init.d/*
echo ${REL}
exit 0
