## Swarm

### CAVEATS
* [Traefik is a layer 7 reverse proxy](https://docs.traefik.io/)
* Docker Terraform provider not stable, so `docker stack deploy` used for swarm stacks deploy

### Keys

- [AWS KMS](https://aws.amazon.com/kms/pricing/) (Hardware) $1 per month. $0.03 per 10,000 requests, free tier of 20,000 requests/month
- [GCloud KMS](https://cloud.google.com/kms/pricing) (Hardware) $1 per month. $0.03 per 10,000 operations
- GCloud KMS (Software) $0.06 per month. $0.03 per 10,000 operations

https://www.codementor.io/@byjg/creating-a-docker-swarm-stack-with-terraform-terrascript-python-persistent-volumes-and-dynamic-haproxy-x57fmbvhq

https://poweruser.blog/how-to-encrypt-secrets-in-config-files-1dbb794f7352?gi=47a33348fa5


##### Articles

[ Vault vs. Amazon KMS](https://www.vaultproject.io/docs/vs/kms.html)

### Troubleshooting

`docker service ls`

`docker service ps traefic`

`docker service logs traefic`

`sudo journalctl -fu docker.service`

##### Articles
- [Docker Logging: A Complete Guide](https://sematext.com/guides/docker-logs/)

### DNS
Setup can be done like [this](https://askubuntu.com/questions/1029882/how-can-i-set-up-local-wildcard-127-0-0-1-domain-resolution-on-18-04?rq=1)

For IP of docker network see `ifconfig`

Modify:
- Edit `/etc/NetworkManager/dnsmasq.d/example.com-wildcard.conf` string `address=/.th.is/172.21.0.1`
- `sudo systemctl reload NetworkManager`  


