# Docker images for RPKI Relying Party software

This repository defines Docker images for RPKI Relying Party software packages which do not, at least to my knowledge at the time of writing, make such images publically available.

I created these images to reduce deployment time in the cloud to experiment with automated e2e testing of the [NLnet Labs Krill project](https://www.nlnetlabs.nl/projects/rpki/krill/). I hope they can be useful to others but at least initially they may work for me but [YMMV](https://dictionary.cambridge.org/dictionary/english/ymmv).

Each definition is accompanied by a deployed copy of the image on Docker Hub:

| RP Tool | Dockerfile Repo | Docker Hub Image | Image Vendor |
| ------- | --------------- | ---------------- | ------------ |
| [FORT Validator](https://fortproject.net/validator) | [`fortvalidator/`](fortvalidator) | [ximoneighteen/fortvalidator](https://hub.docker.com/r/ximoneighteen/fortvalidator) | Me |
| [Rcynic](https://github.com/dragonresearch/rpki.net/tree/master/rp/rcynic) | [`rcynic/`](rcynic) | [ximoneighteen/rcynic](https://hub.docker.com/r/ximoneighteen/rcynic) | Me |
| [rpki-client](https://medium.com/@jobsnijders/a-proposal-for-a-new-rpki-validator-openbsd-rpki-client-1-15b74e7a3f65) | [`rpki-client/`](rpki-client) | [ximoneighteen/rpki-client](https://hub.docker.com/r/ximoneighteen/rpki-client) | Me |

Additionally, the table below lists other official RP images that I am aware of:

| RP Tool | Dockerfile Repo | Docker Hub Image | Image Vendor |
| ------- | --------------- | ---------------- | ------------ |
| [OctoRPKI](https://blog.cloudflare.com/cloudflares-rpki-toolkit/) | [CloudFlare @ GitHub](https://github.com/cloudflare/cfrpki#octorpki) | [cloudflare/octorpki](https://hub.docker.com/r/cloudflare/octorpki) | CloudFlare |
| [Routinator](https://nlnetlabs.nl/projects/rpki/routinator/) | [NLnet Labs @ GitHub](https://github.com/NLnetLabs/routinator) | [nlnetlabs/routinator](https://hub.docker.com/r/nlnetlabs/routinator) | NLnet Labs |
| [RPKI Validator 3](https://www.ripe.net/manage-ips-and-asns/resource-management/certification/tools-and-resources) | [RIPE NCC @ GitHub](https://github.com/RIPE-NCC/rpki-validator) | [ripencc/rpki-validator-3-docker](https://hub.docker.com/r/ripencc/rpki-validator-3-docker) | RIPE NCC |
| [FORT Validator](https://fortproject.net/validator) | [pcarana @ GitHub](https://github.com/pcarana/docker-images/tree/master/FORT-validator) | N/A | [FORT issue #17](https://github.com/NICMx/FORT-validator/issues/17) |

A more complete list of RPKI Relying Party Software is maintained by NLnet Labs on Read the Docs [here](https://rpki.readthedocs.io/en/latest/tools.html).

## RPKI? Relying Party?

See [RPKI @ Read the Docs](https://rpki.readthedocs.io/en/latest/index.html).

## Disclaimers

These images are for my own use. Where possible I try and make them generally applicable but they:
- Are not verified as ready for production use, use at your own risk!
- Are not supported by me in any way.
- Are not part of, affiliated with or associated with the RP tool vendors.
  - When I consider an image to be good enough I submit it to the vendor for adoption/replacement.
- May not support all of the features of each RP tool out-of-the-box.
- Are also not optimized for the smallest possible image size.
- Are not fully documented.

It is not my intention to violate any rules or rights with these images, I will be happy to remove them if they are in any way anything other than  positive a contribution to the RPKI community.

## Contact

Please raise any problems, requests, questions etc. via GitHub issues.

Ximon
