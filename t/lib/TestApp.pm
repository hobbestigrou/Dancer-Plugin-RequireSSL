package t::lib::TestApp;

use Dancer;
use Dancer::Plugin::RequireSSL;

require_ssl;

get '/' => sub {
    return ;
};

1;
