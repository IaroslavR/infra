resource "docker_service" "traefik" {
  name = "traefic"
  task_spec {
    container_spec {
      image = "traefik:v2.1.1"
      hostname = "traefic"
      mounts {
        target = "/var/run/docker.sock"
        source = "/var/run/docker.sock"
        type   = "bind"
        read_only = true
      }
      command  = [
        "--providers.docker.endpoint=unix:///var/run/docker.sock",
        "--providers.docker.swarmMode=true",
        "--providers.docker.exposedbydefault=false",
        "--providers.docker.network=${docker_network.public.name}",
        "--entrypoints.web.address=:80",
        "--api"
      ]
      labels = {
        "traefik.enable" = "true",
        # Dashboard
        "traefik.http.routers.traefik.rule" = "Host(`traefik.dev`)",
        "traefik.http.routers.traefik.service" = "api@internal",
//        traefik.http.routers.traefik.tls.certresolver: leresolver
        "traefik.http.routers.traefik.entrypoints" = "web",
//        traefik.http.routers.traefik.middlewares: auth-traefik
        # Swarm Mode
        "traefik.http.services.traefik.loadbalancer.server.port" = 80
//        # Basic Auth
//        traefik.http.middlewares.auth-traefik.basicauth.users: "user:authcodehere"
//        # Global http to https redirect
//        traefik.http.routers.http-catchall.rule: "hostregexp(`{host:.+}`)"
//        traefik.http.routers.http-catchall.entrypoints: web
//        traefik.http.routers.http-catchall.middlewares: redirect-to-https
//        # Middleware redirect
//        traefik.http.middlewares.redirect-to-https.redirectscheme.scheme: https
      }
    }
    placement {
      constraints = [
        "node.role==manager",
      ]
    }
    networks = [docker_network.public.id]
  }
  mode {
    replicated {
      replicas = 1
    }
  }
  endpoint_spec {
    ports {
      target_port    = 80
      published_port = 80
    }
    ports {
      target_port    = 8080
      published_port = 8080
    }
  }
}