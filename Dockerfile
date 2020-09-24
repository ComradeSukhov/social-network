FROM ruby:2.7.1
LABEL maintainer = "Anton Krestyaninov <9593795@gmail.com>"
LABEL version = "0.5.8"

# Get necessary packages
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt update -qq && apt install -y nodejs yarn postgresql-client

# Prepare app
WORKDIR /social-network
COPY . .
RUN bundle

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
