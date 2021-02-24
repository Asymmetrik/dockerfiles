FROM node:14-buster-slim

# Chromium v79.0.3945.88 => 706915
ENV REVISION=706915
ENV ZIP_URL="https://www.googleapis.com/download/storage/v1/b/chromium-browser-snapshots/o/Linux_x64%2F${REVISION}%2Fchrome-linux.zip?alt=media"
ENV ZIP_FILE="${REVISION}-chrome-linux.zip"

# Home of node user.
ENV NODE_HOME="/home/node"

# Location of chrome binary.
ENV CHROME_BIN="${NODE_HOME}/chrome-linux/chrome"

# Stop the Angular CLI from asking questions on npm i.
ENV NG_CLI_ANALYTICS=ci

RUN apt-get update -y \
    && apt-get install curl unzip ca-certificates --no-install-recommends -y \
    && apt-get install --no-install-recommends -y \
            libasound2 \
            libatk-bridge2.0-0 \
            libatk1.0-0 \
            libatspi2.0-0 \
            libc6 \
            libcairo2 \
            libcups2 \
            libdbus-1-3 \
            libdrm2 \
            libexpat1 \
            libgbm1 \
            libgcc1 \
            libgdk-pixbuf2.0-0 \
            libglib2.0-0 \
            libglib2.0-0 \
            libgtk-3-0 \
            libnspr4 \
            libnss3 \
            libpango-1.0-0 \
            libpangocairo-1.0-0 \
            libx11-6 \
            libx11-xcb1 \
            libxcb-dri3-0 \
            libxcb1 \
            libxcomposite1 \
            libxcursor1 \
            libxdamage1 \
            libxext6 \
            libxfixes3 \
            libxi6 \
            libxrandr2 \
            libxrender1 \
            libxss1 \
            libxtst6 \
            xdg-utils \
    && rm -rf /var/lib/apt/lists/*

USER node
WORKDIR /home/node
RUN curl -# ${ZIP_URL} > $ZIP_FILE && \
    unzip ${ZIP_FILE} && \
    rm -f ${ZIP_FILE} && \
    rm -rf chrome-linux/resources

CMD [ "/bin/bash" ]