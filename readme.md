# Portfolio
Files for my online portfolio, which is compiled to a static site using Nanoc.

### Development
Development is done through Vagrant. Once the VM has been provisioned with the necessary software, the files in `/vagrant/` can be compiled by running `bundle exec nanoc` or `bundle exec guard -p -l 3` to poll for changes. The site can be viewed with `bundle exec nanoc view`, and the corresponding port will be forward to `localhost:8080` on the host machine.
