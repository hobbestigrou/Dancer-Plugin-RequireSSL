use strict;
use warnings;

use Test::More import => ['!pass'];

use Dancer;
use Dancer::Test;

use lib 't/lib';
use TestApp;

plan tests => 8;

setting environment => 'test';
my $res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 302";
is $res->{headers}->{location}, 'https://localhost/', 'redirect with https';
TODO: {
    local $TODO = 'Does work for this moment';
    is $res->{headers}->{'strict-transport-security'}, 'max-age=31536000', "time max-age is 31536000";
}

setting plugins => {
    RequireSSL => { https_host => 'different_host_ssl' }
};
$res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 302";
is $res->{headers}->{location}, 'https://different_host_ssl/', 'redirect with https on the another host';


setting environment => 'development';
$res = dancer_response GET => '/';
is $res->{status}, 200, "response for GET / is 200 on development env";

setting plugins => {
    RequireSSL => { port => 42 }
};
$res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 302";
is $res->{headers}->{location}, 'https://different_host_ssl:42/', 'redirect with a port';
