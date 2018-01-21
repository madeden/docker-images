# OpenALPR with OpenCV 3.3.1

This Dockerfile builds OpenALPR with OpenCV 3.3.1. 

There are 2 versions of it: 

* With CUDA 8
* Without CUDA 

Yes, the CUDA alone can do both, but it is very big so I built a special one for non GPU compute. 

# Running the image 
## With CUDA

Assuming you have a folder full of car images located at : /data

You can find some datasets on http://www.vision.caltech.edu/Image_Datasets/ for that. 

you can run

```bash
docker run --rm -it \
  -v /usr/lib/nvidia-384/bin:/usr/local/nvidia/bin \
  -v /usr/lib/nvidia-384:/usr/lib/nvidia \
  -v /usr/lib/x86_64-linux-gnu:/usr/lib/cuda \
  -e LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda" \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  -v $PWD/input-images:/in \
  -v $PWD/output-openalpr:/out \
  samnco/openalpr:latest-3.3.1-16.04-cuda-2 \
  openalpr-utils-benchmark us speed /in /out
```

With this [dataset](http://www.vision.caltech.edu/Image_Datasets/cars_brad/cars_brad.tar), on my antique nVidia Quadro M4000, I get: 

```
---------------------
End to End Time Statistics:
	526 samples, avg: 2.87801ms,  stdev: 0.846509

Region Detection Time Statistics:
	526 samples, avg: 2.40921ms,  stdev: 0.638541

State ID Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

Positive Region Analysis Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

Negative Region Analysis Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

OCR Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

Post Processing Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan
```

You can obviously run directly in the container where wget is loaded

```bash
docker run --rm -it \
  -v /usr/lib/nvidia-384/bin:/usr/local/nvidia/bin \
  -v /usr/lib/nvidia-384:/usr/lib/nvidia \
  -v /usr/lib/x86_64-linux-gnu:/usr/lib/cuda \
  -e LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda" \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  -v /data:/in \
  -v $PWD/openalpr.conf.cuda:/etc/openalpr/openalpr.conf \
  samnco/openalpr:latest-3.3.1-16.04-cuda \
  bash
```

Then you can run any command. All utilities are built so you get alpr, all utils, alprd etc.


## CPU Only

Assuming the same folder full of car images located at : /data

you can run

```bash
docker run --rm -it \
  -v /usr/lib/nvidia-384/bin:/usr/local/nvidia/bin \
  -v /usr/lib/nvidia-384:/usr/lib/nvidia \
  -v /usr/lib/x86_64-linux-gnu:/usr/lib/cuda \
  -e LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/lib/nvidia:/usr/lib/cuda" \
  --device /dev/nvidia0:/dev/nvidia0 \
  --device /dev/nvidiactl:/dev/nvidiactl \
  --device /dev/nvidia-uvm:/dev/nvidia-uvm \
  -v /data:/in \
  -v $PWD/openalpr.conf.cpu:/etc/openalpr/openalpr.conf \
  samnco/openalpr:latest-3.3.1-16.04-nocuda \
  openalpr-utils-benchmark us speed /in /tmp
```

With the same data on my Intel® Xeon(R) CPU E5-2670 v3 @ 2.30GHz × 24, I get: 

```
---------------------
End to End Time Statistics:
	526 samples, avg: 18.0969ms,  stdev: 2.19502

Region Detection Time Statistics:
	526 samples, avg: 17.9843ms,  stdev: 2.26739

State ID Time Statistics:
	2 samples, avg: 0.0003375ms,  stdev: 0.0002225

Positive Region Analysis Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

Negative Region Analysis Time Statistics:
	2 samples, avg: 2.95788ms,  stdev: 0.131879

OCR Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan

Post Processing Time Statistics:
	0 samples, avg: -nanms,  stdev: -nan
```

So this gives you a 20x performance boost on the GPU, not bad ;)

# Notes

These images are build from my OpenCV images which you can find in [here](../opencv)


