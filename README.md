# TCP Tunneling for containers over SSH

## Description

This image is a super simple to use helper for using tunneling on your Docker project. This allows you to access remote resources network protected behind an SSH authentication entry server.

It's simple to use, you just need to provide the environment variables. You can have this in your local project or deployed to a Kubernetes cluster very easily.

> **Important**: this image supports authentication using **SSH keys only**, password authentication is **not supported** at the moment.

### Usage

The basics to get a tunnel up and running on a Docker Compose or Kool project:

- Add a new service for the tunneling.
- Set up the SSH/target properly using the environment variables.
- Map to the container your SSH keys for authentication.

For example you can add to your `docker-compose.yml` a new service like this one:

```yaml
  tunnel:
    image: "kooldev/tunnel"
    environment:
      # SSH defines the connection we should use to create the tunnel.
      TUNNEL_SSH_USER: "username"
      TUNNEL_SSH_HOST: "example.com"
      # The SSH port to connect to. The default is 22 so you only
      # need to specify in case you have a custom port.
      # TUNNEL_SSH_PORT: 2222

      # Target is the service you are trying to reach through the tunnel.
      # For example, let's access some Mysql server that is only visible
      # in the the local network
      TUNNEL_TARGET_HOST: 192.168.0.25 # replace this with your real target address
      TUNNEL_TARGET_PORT: 3306 # replace this with your real target port

      # The Listen is the port which the container should bind to.
      # This is the port you are going to use when accessing the
      # container in your other containers: "tunnel:3306"
      TUNNEL_LISTEN: 3306 # change to whatever port you want to use.
    volumes:
      # Share your SSH keys with the container for authentication
      - "$HOME/.ssh:/root/.ssh"

      # Optionally you can share one specific key only.
      # - "./path/to/some_private_key:/root/.ssh/id_rsa"
```

> **Note**: You may wanna add the same `network:` to this service as well, in case you other services already specify some custom network.

**Creating a single container**

If you just want to start a tunnel and maybe bind it to your machine you can do:

```bash
docker run --rm \
    -v ~/.ssh:/root/.ssh \
    -e TUNNEL_SSH_PORT=22 \
    -e TUNNEL_SSH_USER=username \
    -e TUNNEL_SSH_HOST=example.com \
    -e TUNNEL_TARGET_HOST=192.168.0.25 \
    -e TUNNEL_TARGET_PORT=3306 \
    -e TUNNEL_LISTEN=13306 \
    -p 13306:13306 \
    kooldev/tunnel
```

Now with that container running, you can access `localhost:13306` to reach the database behind the SSH tunnel.

### Environment variables

| Variable | Default value | Description |
| - | - | - |
| TUNNEL_SSH_USER | `""` | The user for SSH authentication. |
| TUNNEL_SSH_HOST | `""` | The host to connect with SSH to. |
| TUNNEL_SSH_PORT | `"22"` | The SSH port to use. |
| TUNNEL_TARGET_HOST | `""` | The host of the target. This is usually an internal network address that is only accessible from within the SSH tunnel server. |
| TUNNEL_TARGET_PORT | `""` | The port of the target. |
| TUNNEL_LISTEN | `""` | The port to which the container should bind to. This is the port you are going to reach in the container to access the target host:post through the tunneling. |

## License

The MIT License (MIT). Please see [License File](LICENSE.md) for more information.
