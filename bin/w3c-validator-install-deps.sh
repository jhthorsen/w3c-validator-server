#!/bin/sh

if [ -e 'Makefile.PL' ]; then
    DST=".";
    echo "!! Installing to current directory ...";
else
    DST="$HOME/.w3c-validator-server";
    mkdir -p $DST;
    echo "!! Installing to $DST ...";
fi

sudo apt-get install \
    opensp \
    libsgml-parser-opensp-perl \
    libhtml-tidy-perl \
    ;

cpanm --sudo Bundle::W3C::Validator

for d in "validator" "sgml-lib"; do
    f="$d.tar.gz";
    [ -e $f ] || wget "http://validator.w3.org/$f";
    tar xfz $f;
done

rsync -va validator*/htdocs $DST/root/;
rsync -va validator*/httpd/cgi-bin $DST/root/;
rsync -va validator*/share/templates $DST/root/;

mv root/htdocs/config $DST/config;
rm -rf $DST/root/sgml-lib;
mv root/htdocs/sgml-lib $DST/root/sgml-lib;

perl -pi -e'
    s,#*Base\s*.*,Base = $ENV{PWD},;
    s,#*Templates\s*=.*,Templates = root/templates,;
    s,#*TidyConf\s*=.*,TidyConf = config/tidy.conf,;
    s,#*Library\s*=.*,Library = root/sgml-lib,;
' $DST/config/validator.conf;

perl -pi -e'
    s,style/base",style/base.css",;
' $DST/root/htdocs/*html
