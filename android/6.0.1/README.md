# registry.nocsi.org/odroidc2-android  

[`registry.nocsi.org/odroidc2-android`][1] is a [docker][2] image that bundles the following:  
* **[Android 6.0.1][3]:**

## Details
* The following volumes exist:  
  - /android
  - /opt/toolchains
* /android is your default workdir. *Knowing this will be helpful when you're mounting your playbooks for execution.*   

## Usage 
This image can easily be extended.  

````
docker run --rm=true 
        -v $(pwd)/build:/android/src \
	registry.nocsi.org/odroidc2-android:6.0.1 
cp build/out/* [somewhere]
````

## Misc. Info 
* Latest version: 6.0.1   
* Built on: 2017-05-12T21:12:58EDT   
* Base image: registry.nocsi.org/archlinux-aur:latest ([dockerfile][6])  
* [Dockerfile][7]

[1]: https://hub.docker.com/r/registry.nocsi.org/odroidc2-android/   
[2]: https://docker.com 
