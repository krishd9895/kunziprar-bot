FROM archlinux:latest

# Update and install packages
RUN pacman -Syyu --noconfirm && \
    pacman -S --noconfirm python-pip zstd p7zip gcc git ffmpeg && \
    python3 -m venv /venv && \
    pacman -Scc --noconfirm

# Set PATH for the virtual environment
ENV PATH="/venv/bin:$PATH"

# Upgrade pip, setuptools, wheel, and create /app directory
RUN pip3 install -U pip setuptools wheel && \
    mkdir /app

# Set the working directory
WORKDIR /app

# Copy all files
COPY . /app

# Install Python dependencies
RUN pip3 install -U -r requirements.txt

# Copy environment file
COPY .env /app/.env

# Set the command to run the script
CMD ["/bin/bash", "start.sh"]
