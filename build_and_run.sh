docker build -t deepstream_video_processor . 
docker run --gpus all -it --rm -v /tmp/.X11-unix:/tmp/.X11-unix   -e DISPLAY=$DISPLAY --net=host deepstream_video_processor

