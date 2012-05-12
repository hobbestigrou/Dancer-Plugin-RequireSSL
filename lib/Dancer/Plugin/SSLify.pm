package Dancer::Plugin::SSLify;

use strict;
use warnings;

use Dancer ':syntax';
use Dancer::Plugin;

#ABSTRACT: Configure your application to redirect all incoming requests to HHTPS

register sslify => sub {
    hook before => sub {
        my $req = request;
        _redirect_to_ssl($req);
    };
    hook after => sub {
        _set_hsts_header();
    };
};

sub _redirect_to_ssl {
    my $req = shift;
    if ( ! request->secure ) {
        if ( $req->base =~ /http:\/\//
            || $req->header('X-Forwarded-Proto') !~ 'https') {
            my $url = 'https://' . $req->host . $req->path;

            return redirect($url);
        }
    }
}

sub _set_hsts_header {
    my $settings    = plugin_setting;
    my $hsts_age    = $settings->{hsts_age} // 31536000;
    my $subdomains  = $settings->{hsts_include_subdomains} // 0;
    my $hsts_policy = "max-age=$hsts_age";

    $hsts_policy .= '; includeSubDomains' if $subdomains;

    header 'Strict-Transport-Security' => $hsts_policy;

    return;
}

register_plugin;

1;
