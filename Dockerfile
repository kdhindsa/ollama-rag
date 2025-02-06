# Use the official Ollama image as the base
FROM ollama/ollama:latest

# Optionally install extra packages, for example Python and pip
RUN apt-get update && apt-get install -y python3 python3-pip

# Copy your project code into the container
COPY . /app
WORKDIR /app

# Install Python dependencies
RUN pip3 install -r requirements.txt

# (Optional) Pre-download a smaller model so it's ready at runtime.
RUN sh -c "ollama serve & sleep 10 && ollama pull llama3.2:1b && pkill ollama"

# Clear the base image's ENTRYPOINT so our CMD runs as intended
ENTRYPOINT []

# Set the default command.
# Note: Running multiple processes (the Ollama server and your Python app) in one container
# is possible with a process manager (e.g., supervisord), but the recommended approach is to separate them.
CMD ["sh", "-c", "ollama serve & python3 app.py"]

