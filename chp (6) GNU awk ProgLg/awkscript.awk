BEGIN { FS=":" }
{ print "dn: uid="$1", " "dc=example"", " "dc=com""\n""cn: "$2" "$3"\n""sn: "$3"\n""telephoneNumber: "$4 }
