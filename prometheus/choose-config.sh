#!/bin/sh
# Avoid needing multiple grafana.yml files by checking CLIENT, which is COMPOSE_FILE, for the
# Prometheus config we need.
# Expects a full prometheus command with parameters as argument(s)

case "$CLIENT" in
  *lh-base* ) conffile=lh-prom.yml ;;
  *lh-consensus* ) conffile=lhcc-prom.yml ;;
  *prysm-base* ) conffile=prysm-prom.yml ;;
  *prysm-consensus* ) conffile=prysmcc-prom.yml ;;
  *nimbus-base* ) conffile=nimbus-prom.yml ;;
  *nimbus-consensus* ) conffile=nimbus-prom.yml ;;
  *teku-base* ) conffile=teku-prom.yml ;;
  *teku-consensus* ) conffile=teku-prom.yml ;;
  * ) conffile=none.yml ;;
esac

cp /etc/prometheus/$conffile /etc/prometheus/prometheus.yml

case "$CLIENT" in
  *geth* ) cat /etc/prometheus/geth-prom.yml >> /etc/prometheus/prometheus.yml ;;
  *erigon* ) cat /etc/prometheus/erigon-prom.yml >> /etc/prometheus/prometheus.yml ;;
  *besu* ) cat /etc/prometheus/besu-prom.yml >> /etc/prometheus/prometheus.yml ;;
  *nm* ) cat /etc/prometheus/nethermind-prom.yml >> /etc/prometheus/prometheus.yml ;;
  *oe* ) cat /etc/prometheus/oe-prom.yml >> /etc/prometheus/prometheus.yml ;;
esac

case "$CLIENT" in
  *blox-ssv* ) cat /etc/prometheus/blox-ssv-prom.yml >> /etc/prometheus/prometheus.yml ;;
esac

exec "$@" --config.file=/etc/prometheus/prometheus.yml
