#!/usr/bin/perl
#
# A quick hack (<1 hr) Perl script to play a game of snap.  This is the
# second version which modularises the code written as a prototype (see
# snap1.pl).
#
#  usage:
#    $ snap2.pl <n_players>
#
# An optional argument can be used to specify the number of players.
# It defaults to 2 players.
#
# The script doesn't allow you to play a proper game but acts as more of a
# simulation.  A standard deck of 52 cards is dealt to the N players.  Each
# player lays a card in turn until subsequent cards match either in suite or
# rank (obviously they can't match both in a single deck - would need to fix
# if adapting to use multiple decks).  The cards in the pile are then given
# to the player who laid the most recent card.
#
# The winner is the first person to discard all their cards.
#
# Written by Andy Wardley, March 2015
#

use Badger
    lib   => '../lib';
use Acme::Snap;


#-----------------------------------------------------------------------------
# Configuration options
#-----------------------------------------------------------------------------

our $N_PLAYERS = shift @ARGV || 2;


#-----------------------------------------------------------------------------
# Play the game
#-----------------------------------------------------------------------------

my $game = Acme::Snap->new( players => $N_PLAYERS );

$game->play;
