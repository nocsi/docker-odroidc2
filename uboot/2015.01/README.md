# nocsigroup/odroidc2-uboot  

[`nocsigroup/odroidc2-uboot`][1] is a [docker][2] image that bundles the following:  
* **[U-Boot 2015.01][3]:**

## Details
* The following volumes exist:  
  - /uboot
  - /opt/toolchains
* /uboot is your default workdir. *Knowing this will be helpful when you're mounting your playbooks for execution.*   

## Usage 
This image can easily be extended.  

````
docker run --rm=true 
        -v $(pwd)/out:/uboot/out \
	nocsigroup/odroidc2-uboot:2015.01 
````

## Misc. Info 
* Latest version: 2015.01   
* Built on: 2016-12-02T09:30:58EST   
* Base image: nocsigroup/archlinux-aur:latest ([dockerfile][6])  
* [Dockerfile][7]

[1]: https://hub.docker.com/r/nocsigroup/odroidc2-uboot/   
[2]: https://docker.com 
