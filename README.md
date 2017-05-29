
# Android 7 (SDK 25.X)
### based on [beevelop/java](https://github.com/beevelop/docker-java)
- Ant 1.9.6
- Maven 3.3.9
- Java 1.8.0_111
- Gradle 3.4.1
- Android SDK 24.4.1
    + APIs: android-25
    + Build-Tools: 25.0.2

----
### Pull from Docker Hub
```
docker pull ohoeltke/docker-android:latest
```

### Build from GitHub
```
docker build -t ohoeltke/docker-android github.com/ohoeltke/docker-android
```

### Run image
```
docker run -it ohoeltke/docker-android bash
```

### Use as base image
```Dockerfile
FROM ohoeltke/docker-android:latest
```

----

![One does not simply use latest](https://i.imgflip.com/1fgwxr.jpg)
