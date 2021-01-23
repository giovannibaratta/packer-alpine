VERSION_TO_OLD=apk info -v | grep ifupdown | sed 's/ifupdown-ng-//g'
apk add ifupdown=$VERSION_TO_OLD
mv /sbin/ifdown /sbin/ifdownbroken

echo 'if [[ "$#" -eq 1 ]]; then
  # Apply fix
  ip addr | grep "$1" | grep -i UP > /dev/null
  if [[ $? -eq 0 ]]; then
    /sbin/ifupdown ifdown -i /etc/network/interfaces $1
  else
    echo "$1 alredy down or not exists"
  fi
else
  /sbin/ifupdown ifdown $@
fi' > /sbin/ifdown

chmod u+x /sbin/ifdown