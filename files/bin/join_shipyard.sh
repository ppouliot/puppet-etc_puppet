#!/bin/bash
curl -sSL https://shipyard-project.com/deploy | ACTION=node DISCOVERY=etcd://10.9.1.11:4001 bash -s
