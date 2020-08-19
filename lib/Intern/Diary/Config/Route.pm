package Intern::Diary::Config::Route;

use strict;
use warnings;
use utf8;

use Intern::Diary::Config::Route::Declare;

sub make_router {
    return router {
        connect '/' => {
            engine => 'Index',
            action => 'default',
        };
        connect '/add' => {
            engine => 'Diary',
            action => 'add_get',
        } => { method => 'GET' };
        connect '/add' => {
            engine => 'Diary',
            action => 'add_post',
        } => { method => 'POST'};
        connect '/{id}' => {
            engine => 'Entry',
            action => 'default',
        };
        connect '/{id}/add' => {
            engine => 'Entry',
            action => 'add_get',
        } => { method => 'GET'};
        connect '/{id}/add' => {
            engine => 'Entry',
            action => 'add_post',
        } => { method => 'POST'};
    };
}

1;
