# registry.nocsi.org/odroidc2-uboot  

[`registry.nocsi.org/odroidc2-uboot`][1] is a [docker][2] image that bundles the following:  
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
	registry.nocsi.org/odroidc2-uboot:2015.01 
````

## Misc. Info 
* Latest version: 2015.01   
* Built on: 2017-05-12T21:12:58EDT   
* Base image: registry.nocsi.org/archlinux-aur:latest ([dockerfile][6])  
* [Dockerfile][7]

[1]: https://hub.docker.com/r/registry.nocsi.org/odroidc2-uboot/   
[2]: https://docker.com 
