#!/bin/bash

/usr/local/bin/rake spec:lyw25654a
st=$?

if [ 0 == $st ]; then
{
          echo "From: serverspec@local.infra.active-ssa.com"
          echo "To: kamiyama@qualitia.co.jp"
          echo "Subject: disk alert"
          echo "Content-Type: text/plain; charset=iso-2022-jp"
          echo "ミライトのdiskが95%超えました"
          echo ""
          echo "ミライト:lyw25654[ac].local.active-ssa.com"
          echo ""
          echo "From Serverspec"
} | /usr/sbin/sendmail -i -f kamiyama@qualitia.co.jp -t kamiyama@qualitia.co.jp
fi
