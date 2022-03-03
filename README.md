# PhoXiControl inside the docker image
This is a short manual on deploying the PhoXiControl inside the a docker image



## Build

Select a desired Ubuntu 18.04 installer and copy it to the `context/installer/phoxi.run` file.

Once the installer is present, proceed with the image build process:

```bash
DOCKER_BUILDKIT=1 docker build -t "photoneo/phoxicontrol:latest" -f Dockerfile context
```



## Run

In order to be able to run the image, `docker` must be set up to be able to pass X:

```bash
sudo xhost +local:docker
```

To run the image containing the PhoXiControl, use `docker-compose` inside the root of the project directory:

```bash
 docker-compose up -d
```

The running image will display the PhoXiControl GUI.



## Stop

To stop the running PhoXiControl image, use `docker-compose` inside the root of the project directory:

```bash
docker-compose down
```



## Notes

Consider mounting the scans directory using a dedicated volume.
