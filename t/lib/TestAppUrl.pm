package t::lib::TestApp;

use Dancer;
use Dancer::Plugin::RequireSSL;

get '/' => require_ssl_url sub {
    my $value = 42;

    return $value;
};

get '/try' => sub {
    my $sum = 2 + 2;

    return $sum;
};

1;
