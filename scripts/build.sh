#!/bin/bash

set -e

cd /build/tidb && make
cd /build/pd && make

if [ $1 = "aarch64" ]; then
    echo /build/tikv && ROCKSDB_SYS_SSE=0 make dist_release
else
    echo /build/tikv && make dist_release
fi


cd /build/tidb/bin && cp tidb-server /out
cd /build/tikv/bin && cp tikv-server tikv-ctl /out
cd /build/pd/bin && cp pd-server pd-ctl pd-recover /out
