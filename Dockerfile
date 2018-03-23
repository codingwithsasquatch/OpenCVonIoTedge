FROM armhf/debian

ENV EdgeHubConnectionString YourConnectionStringHere

WORKDIR /app

RUN apt-get update && apt-get install -y \
  python3  \
  python3-dev python3-pip  \
  libboost-all-dev  \
  libcurl4-openssl-dev  \
  pkg-config libjpeg-dev libtiff5-dev libjasper-dev \
  libpng12-dev libavcodec-dev libavformat-dev libswscale-dev \
  libv4l-dev libxvidcore-dev libx264-dev python3-yaml \
  python3-scipy python3-h5py git && \
  apt-get clean && rm -rf /var/lib/apt/lists/*

# OpenCV
ENV OPENCV_VERSION="3.2.0"
ENV OPENCV_DIR="/opt/opencv/"

ADD https://github.com/opencv/opencv/archive/${OPENCV_VERSION}.tar.gz ${OPENCV_DIR}

# RUN cd ${OPENCV_DIR} && \
#     tar -xzf ${OPENCV_VERSION}.tar.gz && \
#     ls -l && \
#     rm ${OPENCV_VERSION}.tar.gz && \
#     mkdir ${OPENCV_DIR}opencv-${OPENCV_VERSION}/build && \
#     cd ${OPENCV_DIR}opencv-${OPENCV_VERSION}/build && \
#     cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local .. && make -j4 && make install && \
#     mv /usr/local/lib/python3.4/dist-packages/cv2.cpython-34m.so /usr/local/lib/python3.4/dist-packages/cv2.so && \
#     rm -rf ${OPENCV_DIR}

COPY requirements.txt ./
RUN pip install -r requrements.txt

COPY . .

CMD ["python","-u", "main.py"]