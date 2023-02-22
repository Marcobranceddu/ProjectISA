# syntax=docker/dockerfile:1
FROM ruby:3.1.1-bullseye

# PostgreSQL client
RUN apt-get update -q && apt-get install -y postgresql-client

# Install node using nvm
RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash && \
    . ~/.bashrc && \
    nvm install lts/gallium && \
    echo -e "\nnvm use lts/gallium" >> ~/.bashrc

# Install gems
WORKDIR /dbg-events
COPY Gemfile /dbg-events/Gemfile
COPY Gemfile.lock /dbg-events/Gemfile.lock
RUN bundle install

# Script to be executed every time the container starts
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 80
RUN rails tailwindcss:watch

# Main process to run
CMD ["rails", "server", "-b", "0.0.0.0"]
