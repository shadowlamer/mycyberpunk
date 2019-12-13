# My Cyberpunk

Website written in Sinclair BASIC. Or at least fixture to run ZX Spectrum emulator 
at your web page. I've decided to use my personal page as content example ))

### Run dev server
```
npm start
```

### Compose .tap file from BASIC source and images
```
npm run make-tape
```
You need *zmakebas* and *bin2tap* and *M4* installed.
```
sudo apt install zmakebas m4
```

### Build web bundle
```
npm run build
```

### Make docker image

##### Prerequisites

1. You need "docker" installed.
2. A self-signed certificate for nginx will be generated when building. Further
it can be replaced. 

3. Key generation requires a fair amount of entropy. Docker uses host machine
entropy source. Therefore, to speed up the build it is recommended to install
haveged
```
sudo apt-get install haveged
sudo service haveged start 
```

##### Image building

```
sudo npm run docker:build -- [<parameters>]
```

For each parameter you need to specify:

```
--build-arg <parameter_name>=<value>
```

##### Available parameters

| Parameter              | Description                |
| ---------------------- |:---------------------------|
| site_url               | Deploying URL              |
| maintainer_email       | Email to generate SSL key  |
