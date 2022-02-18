# PhoXiControl inside the docker image
This is a short manual on deploying the PhoXiControl inside the a docker image

## Before build
Select a desired Ubuntu 18.04 installer and copy it to the `context/installer/phoxi.run` file.

### Install nvidia-container-runtime
```bash
curl -s -L https://nvidia.github.io/nvidia-container-runtime/gpgkey | sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-container-runtime/$distribution/nvidia-container-runtime.list | sudo tee /etc/apt/sources.list.d/nvidia-container-runtime.list
sudo apt-get update
sudo apt-get install nvidia-container-runtime
```
#### Update docker daemon
Add `/etc/docker/daemon.json` file with this content
```yml
{
  "runtimes": {
  "nvidia": {
    "path": "/usr/bin/nvidia-container-runtime",
    "runtimeArgs": []
    }
  }
}
```

#### Restart docker service
```bash
sudo systemctl restart docker.service
```

### Test nvidia docker
To make sure Nvidia support works run the following docker image:
```bash
sudo docker run --rm --gpus all nvidia/cuda:10.0-base nvidia-smi
```

Which should result in something similar output:

```
+-----------------------------------------------------------------------------+
| NVIDIA-SMI 418.56       Driver Version: 418.56       CUDA Version: 10.1     |
|-------------------------------+----------------------+----------------------+
| GPU  Name        Persistence-M| Bus-Id        Disp.A | Volatile Uncorr. ECC |
| Fan  Temp  Perf  Pwr:Usage/Cap|         Memory-Usage | GPU-Util  Compute M. |
|===============================+======================+======================|
|   0  GeForce RTX 2060    Off  | 00000000:01:00.0  On |                  N/A |
| N/A   57C    P8     7W /  N/A |   1586MiB /  5904MiB |      6%      Default |
+-------------------------------+----------------------+----------------------+

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
+-----------------------------------------------------------------------------+
```


## Build

Once the installer is present, proceed with the image build process:

```bash
DOCKER_BUILDKIT=1 docker build -t "photoneo/phoxicontrol:latest" -f Dockerfile context
```



## Run

In order to be able to run the image, `docker` must be set up to be able to pass `nvidia` runtime and you have to execute:

```bash
xhost +
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
