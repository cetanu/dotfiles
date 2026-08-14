FROM hugojosefson/popos:latest

ENV DEBIAN_FRONTEND=noninteractive
WORKDIR /root/dotfiles

# These are the only dependencies needed before mise can bootstrap the host.
RUN apt-get update \
    && apt-get install --yes --no-install-recommends ca-certificates curl git \
    && rm -rf /var/lib/apt/lists/*

COPY . .

RUN curl https://mise.run | sh
ENV PATH="/root/.local/bin:${PATH}"

RUN mise trust \
    && mise bootstrap --yes --dry-run \
    && mise bootstrap --yes --only dotfiles,mise-shell-activate
