# Start from the official Go image to create a build artifact.
# This is the first stage of a multi-stage build.
FROM golang:1.18-alpine AS builder

# Set the working directory inside the container.
WORKDIR /app

# Copy go.mod and go.sum to download dependencies.
COPY go.mod go.sum ./
RUN go mod download


# Copy the rest of the source code.
COPY . .

# Compile the binary. 
# You can add flags to build a statically linked binary.
RUN CGO_ENABLED=0 GOOS=linux go build -o myapp

# Start from a smaller image to create a smaller final image.
FROM alpine:latest  

# Copy the pre-built binary file from the previous stage.
COPY --from=builder /app/myapp .

# Command to run the executable.
CMD ["./myapp"]
