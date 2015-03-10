package Acme::Snap;

use 5.016003;
use Badger::Class
    debug => 1,
    base  => 'Badger::Base';
use List::Util 'shuffle';

our $VERSION = '0.01';
our $PLAYERS = 2;

sub init {
    my ($self, $config) = @_;
    $self->debug("init game") if DEBUG;
    $self->{ players } = $config->{ players } || $PLAYERS;
    $self->debug("players: $self->{ players }") if DEBUG;
    return $self;
}

sub play {
    shift->todo;
}


1;

__END__

=head1 NAME

Acme::Snap - a simple game of Snap!

=head1 SYNOPSIS

    use Acme::Snap;

    my $game = Acme::Snap->new( players => 2 );

    $game->play;

=head1 DESCRIPTION

TODO

=head1 AUTHOR

Andy Wardley, E<lt>abw@wardley.orgE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2015 by Andy Wardley

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.16.3 or,
at your option, any later version of Perl 5 you may have available.

=cut
