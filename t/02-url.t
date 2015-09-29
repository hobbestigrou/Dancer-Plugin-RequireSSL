use strict;
use warnings;

use Test::More import => ['!pass'];

use Dancer;
use Dancer::Test;

use lib 't/lib';
use TestAppUrl;

plan tests => 9;

setting environment => 'test';
my $res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 302";
is $res->{headers}->{location}, 'https://localhost/', 'redirect with https';
is $res->{content}, 42, 'Test the content';

$res = dancer_response GET => '/try';
is $res->{status}, 200, "response for GET / is 200";
is $res->{content}, 4, 'Test the content';

setting plugins => {
    RequireSSL => { https_host => 'different_host_ssl' }
};
$res = dancer_response GET => '/';
is $res->{status}, 302, "response for GET / is 302";
is $res->{headers}->{location}, 'https://different_host_ssl/', 'redirect with https on the another host';


setting environment => 'development';
$res = dancer_response GET => '/';
is $res->{status}, 200, "response for GET / is 200 on development env";
is $res->{content}, 42, 'Test the content';
