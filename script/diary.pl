#!/usr/bin/env perl
use strict;
use warnings;
use utf8;

use Encode qw(encode_utf8 decode_utf8);
use Pod::Usage;

use FindBin;
use lib "$FindBin::Bin/../lib";

use DBIx::Sunny;


use Intern::Diary::Config;
use Intern::Diary::Service::User;
# use Intern::Diary::Service::Diary;

BEGIN { $ENV{INTERN_DIARY_ENV} = 'local' };

# my %HANDLERS = (
#     add    => \&add_bookmark,
# );

my $name    = shift @ARGV;
# my $command = shift @ARGV;

my $db      = do {
    my $config = config->param('db')->{intern_diary};
    DBIx::Sunny->connect(map { $config->{$_} } qw(dsn user password));
};

my $user = Intern::Diary::Service::User->find_user_by_name($db, +{ name => $name });
unless ($user) {
    $user = Intern::Diary::Service::User->create($db, +{ name => $name });
}

print $user;
