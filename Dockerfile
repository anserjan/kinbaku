FROM ruby:3.0.6

# prepare work directory
RUN mkdir -p /opt/app
WORKDIR /opt/app

# install OS dependencies
RUN curl -fsSL https://deb.nodesource.com/setup_21.x | bash -
RUN apt install -y --no-install-recommends libvips nodejs

# copy minimal set of files for installing bundle dependencies
COPY Gemfile .
COPY lib/gems lib/gems
RUN bundle install

# copy everything else
COPY . .

# ready to go!
ENTRYPOINT ["rails", "server", "-b", "0.0.0.0"]

