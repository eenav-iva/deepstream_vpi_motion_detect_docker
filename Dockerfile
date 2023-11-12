FROM nvcr.io/nvidia/deepstream:6.3-gc-triton-devel

# To get video driver libraries at runtime (libnvidia-encode.so/libnvcuvid.so)
ENV NVIDIA_DRIVER_CAPABILITIES $NVIDIA_DRIVER_CAPABILITIES,video

RUN apt update
#RUN apt install -y python3-gi python3-dev python3-gst-1.0 python3-numpy python3-opencv

# Compile Python bindings
RUN bash user_additional_install.sh
RUN bash user_deepstream_python_apps_install.sh -v 1.1.8
RUN apt install python3-numpy python3-opencv feh -y

#RUN apt-get install gstreamer1.14-ffmpeg gstreamer1.14-fluendo-mp3 gstreamer1.14-plugins-bad gstreamer1.14-bad-multiverse gstreamer1.14-plugins-base gstreamer1.14-good gstreamer1.14-ugly gstreamer1.14-ugly-multiverse
RUN apt install gnupg -y
RUN apt-key adv --fetch-key https://repo.download.nvidia.com/jetson/jetson-ota-public.asc -y
RUN apt install software-properties-common -y

RUN  add-apt-repository 'deb https://repo.download.nvidia.com/jetson/x86_64/focal r35.2 main' -y
RUN apt update
RUN apt install libnvvpi2 vpi2-dev vpi2-samples  libgstreamer-plugins-base1.0-dev libgstreamer1.0-dev libopencv-dev ffmpeg -y 
RUN  apt install python3.8-vpi2
#sudo apt install vpi2-demos

#RUN cd /opt/nvidia/deepstream/deepstream/samples && bash prepare_ds_triton_tao_model_repo.sh 
#RUN mkdir /opt/nvidia/deepstream/deepstream/samples/models/Tracker/
#COPY resnet50_market1501.etlt /opt/nvidia/deepstream/deepstream/samples/models/Tracker/
#COPY labels.txt /opt/nvidia/deepstream/deepstream-6.3/samples/triton_tao_model_repo/peoplenet_transformer/
#remove uneeded models for in same docker local triton use
#RUN    rm /opt/nvidia/deepstream/deepstream-6.3/samples/triton_tao_model_repo/peoplesemsegnet_shuffle -r
#RUN    rm /opt/nvidia/deepstream/deepstream-6.3/samples/triton_tao_model_repo/faciallandmark/ -r
#RUN    rm /opt/nvidia/deepstream/deepstream-6.3/samples/triton_tao_model_repo/facenet/ -r

#RUN    cd /opt/nvidia/deepstream/deepstream/samples/ \ 
#       && git clone https://github.com/NVIDIA-AI-IOT/deepstream_tao_apps.git

#apt install python3-gi python3-dev python3-gst-1.0 python-gi-dev git python-dev \
#    python3 python3-pip python3.8-dev cmake g++ build-essential libglib2.0-dev \
#    libglib2.0-dev-bin libgstreamer1.0-dev libtool m4 autoconf automake libgirepository1.0-dev libcairo2-dev -y

# RTSP
#RUN apt-get install -y libgstrtspserver-1.0-0 gstreamer1.0-rtsp libgirepository1.0-dev gobject-introspection gir1.2-gst-rtsp-server-1.0

COPY . /opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/
COPY ./labels.txt /opt/nvidia/deepstream/deepstream/samples/triton_tao_model_repo/peoplenet_transformer/
#RUN mv  /opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/dsexample_motion_mask  /opt/nvidia/deepstream/deepstream/sources/gst-plugins/gst-dsexample 
WORKDIR /opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/deepstream-motion-detect-vpi_rtsp_in_out

#Example run:
#python3 main.py -i file:///opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/deepstream_face/data/videos_in/E369.mp4
#CMD python3 main.py -i "file:///opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/deepstream_face/data/videos_in/E369.mp4"
#ENTRYPOINT python3 main.py -i file:///opt/nvidia/deepstream/deepstream/sources/deepstream_python_apps/apps/deepstream_face/data/videos_in/E208.mp4 --handheld_camera
