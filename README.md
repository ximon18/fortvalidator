# `ximoneighteen/fortvalidator` - a FORT Validator Docker image

This repository defines a Docker image containing the [FORT Validator](https://nicmx.github.io/FORT-validator/index.html).

## Credits

- [FORT Project](https://fortproject.net/) - developer of the FORT Validator.

## Disclaimer

*NOTE:* This image is **NOT** supported in any way, nor is it part of, or associated with, the official [FORT project](https://www.fortproject.net/).

## Documentation

 - [FORT Validator](https://nicmx.github.io/FORT-validator/index.html)
 - [RPKI @ FORT Validator](https://nicmx.github.io/FORT-validator/intro-rpki.html)
 - [RPKI @ Read the Docs](https://rpki.readthedocs.io/en/latest/index.html)

## Usage

Basic invocation: `docker run ximoneighteen/fortvalidator`

### Trust Anchor Locators (TALs)

For ease of use the Docker container comes presupplied with the TAL files made available by the FORT Validator project in their GitHub repository [here](https://github.com/NICMx/FORT-validator/tree/master/tal) *(ARIN TAL **not** included, see Advanced Usage below to see how to use your own TAL files)*.

## Examples

The examples below show how to use the Docker image to run the FORT Validator per the FORT Validator [Basic Usage](https://nicmx.github.io/FORT-validator/run.html) instructions. These examples assume that you have the necessary TAL files in your `/tmp/tals` directory.

### FORT Validator as an RTR server

Run FORT Validator and expose its internal RTR server on your port 323, using the included TALs.

```
docker run -p 323:323 ximoneighteen/fortvalidator
```

A more complete example:


```
docker volume create fortrepo
docker run -d --name fort -p 323:323 -v /my/tals:/tals -v fortrepo:/repo ximoneighteen/fortvalidator
```

`-d` runs the container in the background (daemon mode).
`-v` mounts volumes for TALs (`/my/tals` is a path on the host computer) and repository/cache content (`fortrepo` is a pre-created Docker volume).

When using `-d` to run the service in the background the logs can be tailed like so:

```
docker logs -f fort
```


### FORT Validator as a standalone one-shot validator

```
mkdir /tmp/out
docker run --rm -v /tmp/out:/tmp/ ximoneighteen/fortvalidator --mode standalone --output.roa /tmp/roas.json
```

### FORT Validator using a SLURM file

```
docker run --rm -v /tmp/my.slurm:/tmp/ ximoneighteen/fortvalidator --slurm /tmp/my.slurm
```